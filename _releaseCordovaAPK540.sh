#!/bin/bash

./build.sh release

echo "Copying public folder to cordova 'www' folder"

cp -Rf ./build/web/ ./cordova540/www/

cd ./cordova540
sudo cordova build android --release

cd ..
open cordova540/platforms/android/build/outputs/apk/
