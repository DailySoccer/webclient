#!/bin/sh

pub build
rsync -r  -v --copy-unsafe-links build/web/. ../backend/public/
