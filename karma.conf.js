module.exports = function(config) {
  config.set({
    basePath: '.',
    frameworks: ['dart-unittest'],

    // list of files / patterns to load in the browser
    // all tests must be 'included', but all other libraries must be 'served' and
    // optionally 'watched' only.
    files: [
      'test/*.dart',
      {pattern: '**/*.dart', watched: true, included: false, served: true},
      {pattern: '**/*.html', watched: true, included: false, served: true},
      'packages/browser/dart.js',
      'packages/browser/interop.js'
    ],

    // list of files to exclude
    exclude: [],

    // web server port
    port: 9876,

    // enable / disable colors in the output (reporters and logs)
    colors: true,

    // level of logging
    // possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
    logLevel: config.LOG_INFO,

    // enable / disable watching file and executing tests whenever any file changes
    autoWatch: true,

    // If browser does not capture in given timeout [ms], kill it
    captureTimeout: 5000,

    browserNoActivityTimeout: 25000,

    browsers: [ 'Chrome' ], 
    // browsers: [ 'Firefox', 'Chrome' ], 
    // browsers: [ 'Firefox' ],   


    // Continuous Integration mode
    // if true, Karma captures browsers, runs the tests and exits
    // singleRun: false,

    plugins: [
      'karma-dart',
      'karma-chrome-launcher',
      'karma-firefox-launcher'
    ]
  });
};
