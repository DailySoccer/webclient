#!/bin/sh

source build.sh
rsync -r  -v --copy-unsafe-links build/web/. ../backend/public/

# Revertimos los cambios hechos a distintos ficheros
git checkout -- web/index.html
git checkout -- web/css/styles.css
git checkout -- lib/template_cache.dart