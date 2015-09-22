#!/bin/bash

./build.sh

echo "Copying public folder to cordova 'www' folder"

cp -Rf ./build/web/ ./cordova/www/

cd ./cordova
sudo cordova build ios

cd ..
open cordova/platforms/ios/
