#!/bin/bash

./build.sh

echo "Copying public folder to cordova 'www' folder"

cp -Rf ./build/web/ ./cordova/www/

cd ./cordova
sudo cordova build android

cd ..
open cordova/platforms/android/build/outputs/apk/
