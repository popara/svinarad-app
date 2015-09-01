{id, values, concat, find} = require 'prelude-ls'

angular.module "jonny.providers"
.config <[$stateProvider $urlRouterProvider stateHelperProvider authenticatedOnly notForAuthenticated]> ++
($state-provider, $url-router-provider, state-helper-provider, authenticatedOnly, notForAuthenticated) !->
  s = state-helper-provider.state

  s (do
    name: 'home'
    url: '/'
    template-url: 'app/providers/home/home.html'
    restrict: authenticatedOnly
    controller: 'Model'
    resolve:
      model: 'Home'
  )


  $url-router-provider.otherwise '/'

.config <[$locationProvider]> ++ ($location-provider) !-> $location-provider.html5-mode true
