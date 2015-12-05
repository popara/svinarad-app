angular.module "svinarad.radnik"
.config <[stateHelperProvider $urlRouterProvider authenticatedOnly]> ++ (state-helper-provider, $url-router-provider, authenticatedOnly) !->
  s = state-helper-provider.state

  s do
    name: 'intro'
    url: '/dom'
    template-url: 'app/radnik/intro/intro.html'
    controller: 'Model'
    restrict: authenticatedOnly
    resolve:
      model: 'Intro'



  s do
    name: 'login'
    url: '/login'
    template-url: 'app/radnik/auth/login.html'
    controller: 'ModelOptionsNext'
    resolve:
      model: 'Authentication'
      options: -> {}
      period: -> 100ms
    data:
      next: 'intro'

  s do
    name: 'logout'
    url: '/logout'
    controller: <[Auth]> ++ (auth) !-> auth.$unauth!

  $url-router-provider.otherwise '/dom'
