angular.module "svinarad.poslodavac"
.config <[stateHelperProvider $urlRouterProvider authenticatedOnly]> ++ (state-helper-provider, $url-router-provider, authenticatedOnly) !->
  s = state-helper-provider.state

  s do
    name: 'intro'
    url: '/'
    template-url: 'app/poslodavac/intro/intro.html'
