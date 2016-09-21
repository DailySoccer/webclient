#!/bin/bash

./build.sh

echo "Copying public folder to cordova 'www' folder"

cp -Rf ./build/web/ ./cordova540/www/

cd ./cordova540
#sudo cordova build android
sudo cordova run android

cd ..
