#!/bin/sh

# mode puede ser debug|relesae
pub build --mode=release
rsync -r  -v --copy-unsafe-links build/web/. ../backend/public/
