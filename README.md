[![Build Status](https://drone.io/github.com/DailySoccer/webclient/status.png)](https://drone.io/github.com/DailySoccer/webclient/latest)

Install
=============

- Of course you need to install Dart. The downloaded package from the web includes both the DartEditor and the DartSDK.

  Add the SDK path to your .zshrc (use zsh and oh-my-zsh, for the love of Dijkstra):
  
  PATH=$PATH:$HOME/Documents/Dart/dart-sdk/bin

- Install Node:

	$ webclient > brew install node
	
- Install the npm packages using:

	$ webclient > npm install

	This of course will create the "node_modules/" folder. Hide it in your DartEditor workspace by right-clicking 
	in the root project -> properties, and adding an Exclude filter under the Resources section.
	
- Verify that you have the "dart-sdk/bin" folder in your path: 
    
    $ webclient > dart --version && dart2js --version

  if you don't have it, just include the path in ~/.profile: PATH=$PATH:"path-to-dart"/dart-sdk/bin

- To run karma use the provided script:

  $ webclient > ./run_karma.sh

The browser is launched automatically by karma. You can access it at http://localhost:9876

- To compile automatically the web/less files to css, install grunt-cli and then just run grunt:
  
  + $ webclient > npm install -g grunt-cli
  + $ webclient > grunt
  
  If you need to compile the less files for production:
  
  $ webclient > grunt less:production


Configuring the launches
=========================

Your default launch will look like this:

![alt tag](doc/launch01.png)

The server uses CORS to allow the client to be executed in its own server (localhost:3000 or wherever). But you can also copy 
the output of "pub build" to the backend/public folder and execute directly with the server serving the client as static files.

Resolutions
===========

- Minimum resolution width: 320px
- XS: < 768px
- SM: < 970px
- MD: > 970px

