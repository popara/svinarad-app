module.exports = bower-app = (app-name, deps) ->
  name: "Svi Na Rad: #{app-name}"
  version: "0.9.5"
  main: "_public/js/app.js"
  ignore: ["**/.*", "node_modules", "components"]
  dependencies: {
    "commonjs-require-definition": "~0.1.2"
    "angular-ui-router": "0.2.15"
    "angular": "1.4.5"
    "angular-animate": "1.4.5"
    "angular-cookies": "1.4.5"
    "restangular": "~1.5.1"
    "angularfire": "~1.1.2"
    "visor": "~0.1.1"
    "momentjs": "~2.10.2"
    "angularitics": "~0.20.0"
    "ng-fastclick": "~1.0.2"
    "angular-ui-router.stateHelper": "~1.3.1"
    "prelude-browser-min": "http://gkz.github.io/prelude-ls/prelude-browser-min.js"
    "ramda": "~0.17.1"
    } <<<< deps
