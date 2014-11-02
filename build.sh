#!/bin/sh

mode="release"

if [[ $1 != "" ]]
    then
        mode=$1
fi

# Compilamos nuestros less a css
./compile_less.sh

# mode puede ser debug|release
echo "Client compilation mode is: $mode"
dart cache_gen.dart
pub build --mode=$mode