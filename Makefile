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
	aws s3 sync output/. s3://ebyerly.com/;
	@git add --all
	@git --no-pager diff HEAD
	@echo "Please type commit message:";\
	read commit_message;\
	git commit -m "$$commit_message";\
  git push origin master;

test:
	python autopost.py
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)
	aws s3 sync output/. s3://dev.ebyerly.com/
