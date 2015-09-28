angular.module 'svinarad.poslodavac'
.config <[stateHelperProvider authenticatedOnly]> ++ (state-helper-provider, authenticatedOnly) !->
  s = state-helper-provider.state

  s do
    name: 'login'
    url: '/login'
    template-url: 'app/poslodavac/routes/auth/login.html'
    controller: 'Model'
    resolve:
      model: \Authentication
