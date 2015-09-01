module.exports = bower-app = (app-name, deps) ->
  name: "Svi Na Rad: #{app-name}"
  version: "0.9.5"
  main: "_public/js/app.js"
  ignore: ["**/.*", "node_modules", "components"]
  dependencies: {
    "commonjs-require-definition": "~0.1.2"
    "angular-ui-router": "0.2.11"
    "angular": "1.3.15"
    "angular-animate": "1.3.15"
    "angular-cookies": "1.3.15"
    "restangular": "~1.5.1"
    "angularfire": "~1.0.0"
    "visor": "~0.0.9"
    "momentjs": "~2.10.2"
    "angularitics": "~0.18.0"
    "ng-fastclick": "~1.0.1"
    } <<<< deps
