#!/bin/bash
sitemap-generator https://auragan.fr -o sitemap.xml
git add .
git commit -m "$1"
git push
