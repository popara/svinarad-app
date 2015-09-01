{id, sort-by, head, maximum-by} = require 'prelude-ls'

angular.module "jonny.admin" <[
  app.base
  admin.templates
  app.controllers
  visor
  ui.router
  ui.router.stateHelper
  ngAnimate
  firebase
  fillHeight
  monospaced.elastic
  restangular
  luegg.directives
  angular-capitalize-filter
  duScroll
  ngMdIcons
  ngCookies
]>
