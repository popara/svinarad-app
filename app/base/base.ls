{head, tail, keys, values} = require \prelude-ls

angular.module "app.controllers" []
angular.module "app.base" <[
  app.controllers
  firebase
  restangular
  ui.router
  ui.router.stateHelper
  ng-fastclick
  visor
]>
.config <[$locationProvider]> ++ (lp) !-> lp.html5-mode true
.run <[$rootScope]> ++ ($rootScope) !->
  $rootScope .$on '$stateChangeError' (event, to-state, to-params, from-state, from-params, error) !->
    console.error \UI-Router to-state, to-params, error

.run <[$rootScope]> ++ ($root) !-> $root.moment = moment
.run <[$rootScope]> ++ ($root) !-> $root.get-number = -> _.range 0 it
.run <[$rootScope]> ++ ($root) !->
  e, new-State <- $root.$on '$stateChangeSuccess'
  $root.now-state = new-State.name

.run <[Auth $rootScope]> ++ (Auth, scope) !->
  scope.is-me = (id) -> false

  auth <-! Auth.$on-auth
  scope.auth = auth
  scope.is-me = (id) -> id is auth.uid 
