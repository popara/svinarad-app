angular.module 'svinarad.radnik' <[
  app.base
  radnik.templates
  ngAnimate
]>

.config <[$locationProvider]> ++ (lp) !-> lp.html5-mode true
.run <[$rootScope]> ++ ($root) !->
  e, new-State <- $root.$on '$stateChangeSuccess'
  $root.now-state = new-State.name

.run <[$rootScope]> ++ ($rootScope) !->
  $rootScope.$on '$stateChangeError' (event, to-state, to-params, from-state, from-params, error) !->
    console.error \UI-Router error, error.stack
