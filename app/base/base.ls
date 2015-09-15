{keys, values} = require \prelude-ls

angular.module "app.base" <[
  app.controllers
  firebase
  restangular
  ui.router
  ui.router.stateHelper
  ng-fastclick
  visor
]>

.run <[$rootScope]> ++ ($rootScope) !->
  $rootScope .$on '$stateChangeError' (event, to-state, to-params, from-state, from-params, error) !->
    console.error \UI-Router to-state, to-params, error
  #
.factory 'timestamp' -> -> moment!format 'x'
.factory 'klog' ->
  ->
    console.log it
    it

.filter 'momentize' -> (time, format) -> moment time .format format
.filter 'humanTime' -> ((time, format) -> let t = parse-int time
  if t
  then moment parse-int time .format format
  else ''
)

.run <[$rootScope]> ++ ($root) !-> $root.moment = moment
.run <[$rootScope]> ++ ($root) !-> $root.get-number = -> _.range 0 it
.run <[$rootScope]> ++ ($root) !->
  e, new-State <- $root.$on '$stateChangeSuccess'
  $root.now-state = new-State.name

.config <[$locationProvider]> ++ (lp) !-> lp.html5-mode true

.filter "pronun" -> ((object, type) ->
  pronuns =
    direct:
      male: 'he'
      female: 'she'
      other: 'it'


  pronuns[type][object]
)
.filter 'cnt' -> (x) -> (keys x).length
.filter 'cntItems' -> (x) -> x |> values |> keys |> (.length)
.filter 'toMoment' -> -> moment parse-int it
