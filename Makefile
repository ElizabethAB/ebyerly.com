PY?=python3
PELICAN?=pelican
PELICANOPTS=

BASEDIR=$(CURDIR)
INPUTDIR=$(BASEDIR)/content
OUTPUTDIR=$(BASEDIR)/output
CONFFILE=$(BASEDIR)/pelicanconf.py
PUBLISHCONF=$(BASEDIR)/publishconf.py

publish:
	pip freeze > requirements.txt
	python autopost.py
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(PUBLISHCONF) $(PELICANOPTS)
	aws s3api delete-bucket-website --bucket 'dev.ebyerly.com'
	aws s3 sync output/. s3://ebyerly.com/ --delete;
	@git add --all
	@git --no-pager diff HEAD
	@echo "Please type commit message:";
	@read commit_message;\
	git commit -m "$$commit_message";
	@git push origin master;

test:
	python autopost.py
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)
	aws s3 sync output/. s3://dev.ebyerly.com/
	aws s3api put-bucket-website --bucket dev.ebyerly.com --website-configuration '{"IndexDocument": {"Suffix": "index.html"}, "ErrorDocument": {"Key": "error.html"}}'
