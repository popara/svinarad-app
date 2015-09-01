angular.module "jonny.client" <[
  app.base
  clients.templates
  visor
  ui.router
  ui.router.stateHelper
  ngAnimate
  firebase
  uiGmapgoogle-maps
  fillHeight
  angularPayments
  monospaced.elastic
  luegg.directives
  angular-capitalize-filter
  duScroll
  LocalStorageModule
  restangular
  angulartics
  angulartics.google.analytics
  svg.icons
  vimeoEmbed
]>



.run <[$rootScope $window]> ++ ($rootScope, $window) !->
  e = angular.element $window.document.body
  <-! $rootScope.$on \$stateChangeStart
  e.scroll-top-animated 0, 200

.factory 'timestamp' -> -> moment!format 'x'

.config <[uiGmapGoogleMapApiProvider]> ++ (gmap) !->
  gmap.configure do
    key: 'AIzaSyDUjm9jwxsg4gJslsFMoDx6PfgZDL5G35o'
