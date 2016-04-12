from pelicanconf import PATH, STATIC_PATHS
from bs4 import BeautifulSoup
import os

ap_paths = [os.path.join(PATH, SP) for SP in STATIC_PATHS]

ap_files = []
md_files = []

for path in ap_paths:
    for dirname, dirnames, filenames in os.walk(path):
        for filename in filenames:
            if os.path.splitext(filename)[1] in ".html":
                ap_files += [os.path.join(dirname, filename)]
            if os.path.splitext(filename)[1] in ".md":
                md_files += [os.path.join(dirname, os.path.splitext(filename)[0])]

for fn in ap_files:
    if os.path.splitext(fn)[0] in md_files:
        pass
    else:
        with open(fn) as file:
          sp = BeautifulSoup(file, "html.parser")
        with open(os.path.splitext(fn)[0] + ".md", "w") as outmd:
            title = sp.find_all('title')[0].string
            outmd.write("title: " + title + "\n")
            for link in sp.find_all('meta'):
                if 'name' in link.attrs:
                    outmd.write(link['name'] + ": " + link['content'] + "\n")
            outmd.write("\n")
            rel = os.sep.join(fn.split(os.sep)[1:]).replace("\\", "/")
            outmd.write("[" + title + "]({filename}/" + rel + ")")
