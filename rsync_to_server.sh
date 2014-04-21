#!/bin/sh

rsync -r  -v --copy-unsafe-links build/web/. ../server/public/
