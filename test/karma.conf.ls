module.exports = (karma) ->
    karma.set do
      basePath: "../"
      frameworks: ["mocha", "chai"]
      files:
        * "test/unit/polyfill.js"
        * "_public/js/cfg.js"
        * "_public/js/vendor.js"
        * "_public/**/js/vendor.js"
        * "_public/js/sugar.min.js"
        * "_public/js/svg.min.js"
        * "_public/js/svg.filters.min.js"
        * "node_modules/angular-mocks/angular-mocks.js"
        * "_public/js/index.js"
        * "_public/**/js/templates.js"
        * "_public/**/js/app.js"
        * "test/firebase-utils/mockfirebase.js"
        * "test/firebase-utils/*.js"
        * "test/unit/lib/**/*.ls"
        * "test/unit/**/*.spec.ls"
        * "app/**/*.spec.ls"

      exclude: []
      reporters: ["nyan"]
      port: 9876
      runnerPort: 9100
      colors: true
      logLevel: karma.LOG_INFO
      autoWatch: true
      browsers: <[PhantomJS]>
      captureTimeout: 60000
      plugins: <[karma-mocha karma-chai karma-live-preprocessor
        karma-phantomjs-launcher karma-should karma-nyan-reporter
        karma-firefox-launcher sinon-chai
        ]>
      preprocessors:
        '**/*.ls': ['live']
      singleRun: false
