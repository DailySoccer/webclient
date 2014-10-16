#!/bin/sh

mode="release"

if [[ $1 != "" ]]
    then
        mode=$1
fi

./compile_less.sh

# mode puede ser debug|relesae
pub build --mode=$mode
rsync -r  -v --copy-unsafe-links build/web/. ../backend/public/

git checkout -- .
