#!/bin/bash

./build.sh release

echo "Copying public folder to cordova 'www' folder"

cp -Rf ./build/web/ ./cordova540/www/

cd ./cordova540
sudo cordova build ios

cd ..
open cordova540/platforms/ios/
