angular.module "jonny.providers"
.controller \RootController <[$scope $mdSidenav $mdUtil $state Auth]> ++ (scope, sidenav, util, $state, auth) !->
  scope.toggle = util.debounce !-> sidenav 'left' .toggle!
  scope.go-to = (dest) ->
    scope.toggle!
    $state.go dest

  auth-data <- auth.$on-auth
  scope.auth = auth-data

.run <[$window $rootScope]> ++ ($win, $root) !-> $root.go-back = -> $win.history.back();
.run <[$rootScope]> ++ ($root) !->
  e, new-State <- $root.$on '$stateChangeSuccess'
  $root.now-state = new-State.name
