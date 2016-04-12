#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = 'Elizabeth Byerly'
SITENAME = 'E. Byerly'
SITEURL = "http://dev.ebyerly.com"

PATH = 'content'
STATIC_PATHS = ['images', 'presentations', 'css']
ARTICLE_PATHS = ['presentations', 'development']
PAGE_PATHS = ['pages']

USE_FOLDER_AS_CATEGORY = True
DEFAULT_DATE_FORMAT = '%Y-%m-%d'
DISPLAY_CATEGORIES_ON_MENU = True
READERS = {'html': None}

MENUITEMS = [('Presentations', '/category/presentations.html'),
             ('Development', '/category/development.html')]

TIMEZONE = 'America/New_York'

DEFAULT_LANG = 'en'

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None


# ==============================================================================
# Theme and theme-specific settings
THEME = "themes/crowsfoot"

EMAIL_ADDRESS = "elizabeth.byerly@gmail.com"
GITHUB_ADDRESS = "https://github.com/ElizabethAB"
SO_ADDRESS = "http://stackoverflow.com/users/1657297/elizabethab"
TWITTER_ADDRESS = "https://twitter.com/ByerlyElizabeth"
LINKEDIN_ADDRESS = "https://www.linkedin.com/in/elizabethbyerly"
#FB_ADDRESS = 
PROFILE_IMAGE_URL = "http://ebyerly.com/images/profile-200.jpg"
SITESUBTITLE = "Data, programming, and other trivialities"
SHOW_ARTICLE_AUTHOR = False
LICENSE_URL = "http://choosealicense.com/licenses/mit/"
LICENSE_NAME = "MIT"
