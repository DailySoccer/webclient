#!/bin/sh

mode="debug"

if [[ $1 != "" ]]
    then
        mode=$1
fi

# mode puede ser debug|release
echo "Client compilation mode is: $mode"
dart cache_gen.dart
pub build --mode=$mode