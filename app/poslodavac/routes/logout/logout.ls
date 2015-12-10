angular.module "svinarad.poslodavac"
.config <[stateHelperProvider authenticatedOnly]> ++ (state-helper-provider, authenticatedOnly) !->
  s = state-helper-provider.state
  s do
    name: 'logout'
    url: '/odjava'
    controller: <[Auth]> ++ (auth) !-> auth.$unauth!
