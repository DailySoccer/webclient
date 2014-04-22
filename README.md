[![Build Status](https://drone.io/github.com/DailySoccer/webclient/status.png)](https://drone.io/github.com/DailySoccer/webclient/latest)

Testing
=============

Install Karma
-------------

- Install Node: brew install node  (or download from http://nodejs.org/download/)

- Verify that you have the dart bin folder in your path: 
    
    $ webclient> dart --version && dart2js --version

  if you don't have it -> include path in ~/.profile: PATH=$PATH:"path-to-dart"/dart-sdk/bin

Run Karma
---------

  $ webclient> ./run_karma.sh

After this, you should be able to access the karma server in your browser at http://localhost:9876  
   

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

