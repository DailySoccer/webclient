[![Build Status](https://drone.io/github.com/DailySoccer/webclient/status.png)](https://drone.io/github.com/DailySoccer/webclient/latest)

Testing
=============

Install Karma
-------------

- Install Node: brew install node  (or download from http://nodejs.org/download/)

- Install Karma: npm install -g karma

- Install Karma-Dart: npm install -g karma-dart 

- Verify: karma --version

  if error -> include path in ~/.profile: PATH=$PATH:/usr/local/lib/node_modules/karma/bin

- Verify: dart --version && dart2js --version

  if error -> include path in ~/.profile: PATH=$PATH:"path-to-dart"/dart-sdk/bin

Run Karma
---------

  karma start karma.conf.js

WebClient
=========

Configure Server:

Puede solicitar datos de un servidor "real" o "simulado".

type( ServerRequest, implementedBy: DailySoccerServer )
or
type( ServerRequest, implementedBy: MockDailySoccerServer )


Configuring the launches
=========================

Your default launch will look like this:

![alt tag](doc/launch01.png)

The server uses CORS to allow the client to be executed in its own server (localhost:3000 or wherever). But you can also copy 
the output of "pub build" to the backend/public folder and execute directly with the server serving the client as static files.

