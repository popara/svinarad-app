{id, sort-by, head, maximum-by} = require 'prelude-ls'
angular.module "jonny.providers" <[
  app.base
  providers.templates
  app.controllers
  visor
  ui.router
  ui.router.stateHelper
  ngAnimate
  firebase
  uiGmapgoogle-maps
  fillHeight
  ngMaterial
  monospaced.elastic
  restangular
  luegg.directives
  angular-capitalize-filter
  duScroll
  ngMdIcons
  ngFileUpload
  ngCookies
]>

.run <[$rootScope]> ++ ($rootScope) !->
  $rootScope.$on '$stateChangeError' (event, to-state, to-params, from-state, from-params, error) !->
    console.error \UI-Router error, error.stack

.config <[$mdThemingProvider]> ++ ($mdThemingProvider) !->
  $mdThemingProvider.theme \default
  .primaryPalette 'light-blue'
  .accentPalette 'light-green'


.config <[$httpProvider]> ++ ($httpProvider) !->
  $httpProvider.defaults.xsrfCookieName = 'csrftoken'
  $httpProvider.defaults.xsrfHeaderName = 'X-CSRFToken'

.run <[$http $cookies]> ++ ($http, $cookies) !->
  $http.defaults.headers.post['X-CSRFToken'] = $cookies.csrftoken

.config <[RestangularProvider HerokuBackendURLProvider]> ++ (RP, HP) !->
  RP.set-base-url HP.url!

.provider 'myCSRF' !->
  header-name = "X-CSRFToken"
  cookie-name = 'csrftoken'
  allowed-methods = <[GET POST PUT]>

  @set-header-name = -> header-name := it
  @set-cookie-name = -> cookie-name := it
  @set-allowed-methods = -> allowed-methods := it

  @$get = <[$cookies]> ++ (cookies) -> do
    request: (config) ->
      config.headers[header-name] = cookies[cookie-name]
      config

.config  <[$httpProvider]> ++ ($httpProvider) !->
  $httpProvider.interceptors.push 'myCSRF'
  $httpProvider.defaults.withCredentials = true

.config <[$locationProvider]> ++ (lp) !-> lp.html5-mode true

.run <[$rootScope]> ++ ($root) !->
  e, new-State <- $root.$on '$stateChangeSuccess'
  $root.now-state = new-State.name

.config <[uiGmapGoogleMapApiProvider]> ++ (gmaps) !->
  gmaps.configure do
    key: CONFIG.GOOGLE_PLACES_API_KEY
    libraries: 'places'
