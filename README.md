Install Karma
=============

- Install Node: brew install node  (or download from http://nodejs.org/download/)

- Install Karma: npm install -g karma

- Install Karma-Dart: npm install -g karma-dart 

- Verify: karma --version

  if error -> include path in ~/.profile: PATH=$PATH:/usr/local/lib/node_modules/karma/bin

- Verify: dart --version && dart2js --version

  if error -> include path in ~/.profile: PATH=$PATH:"path-to-dart"/dart-sdk/bin

Run Karma
=========

  karma start karma.conf.js


