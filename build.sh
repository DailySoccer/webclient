#!/bin/sh

mode="debug"

if [[ $1 != "" ]]
    then
        mode=$1
fi

# mode puede ser debug|release
echo "Client compilation mode is: $mode"
export DART_SDK=/usr/local/opt/dart/libexec
echo "DART SDK environment variable set to $DART_SDK"
dart cache_gen.dart
pub build --mode=$mode