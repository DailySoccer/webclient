#!/bin/sh

mode="release"

if [[ $1 != "" ]]
    then
        mode=$1
fi

# mode puede ser debug|relesae
pub build --mode=$mode
rsync -r  -v --copy-unsafe-links build/web/. ../backend/public/
