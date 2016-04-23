Title: Website launched
Date: 2016-04-12
Tags: pelican, publishing
Authors: Elizabeth Byerly
Summary: Quick chronicle of the process to get this site online

This website relies on two public technologies:

  * [Pelican](http://blog.getpelican.com/) for conversion of Markdown into
    styled HTML
  * [AWS S3](https://aws.amazon.com/s3/) for site hosting, accessed by
    [AWS CLI](https://aws.amazon.com/cli/) for automated site updates

Pelican is a good general tool for automatically generating static sites. My
complication was that I have static pages (slidedecks) that I want to be on my
site without any change to their HTML. I was able to build that into Pelican
with four additional steps:

1. Add my static pages and their associated support (images, Javascript, CSS) to
   a folder designated in the "pelicanconf.py" `STATIC_PATHS` variable,
2. Specify `READERS = {'html': None}` in "pelicanconf.py" so it would not try to
   auto-publish the HTML pages with its templates,
3. Make a simple Python script, "autopost.py", which trolls through the
   `STATIC_PATHS` folders for HTML files:
    1. Confirming no corresponding Markdown file has already been made,
    2. Generating a Markdown file to be converted into a post by Pelican,
       linking to the static site and populated by the HTML's `meta` properties,
4. Modify Pelican's Makefile to
    1. Run the "autopost.py" file first,
    2. Run Pelican's default generation, and
    3. Post the updated content to my development site.

When I am ready to publish, the Makefile also includes a flag that will do the
three steps above, except posting to my main landing page, ensuring I have an
updated "requirements.txt" file, and saving all changes to a git repository that
is [shared on GitHub](https://github.com/ElizabethAB/ebyerly.com).
