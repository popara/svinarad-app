angular.module "jonny.providers"
.config <[stateHelperProvider notForAuthenticated]> ++ (shp, notForAuthenticated) !->
  s = shp.state

  s (do
    name: 'signup'
    url: '/signup'
    template-url: 'app/providers/authentication/signup.html'
    controller: 'ModelOptionsNext'
    resolve:
      model: \Authentication
      options: -> {}
      period: -> 1
    data: {next: 'home'}
  )

  s (do
    name: 'login'
    url: '/login'
    template-url: 'app/providers/authentication/login.html'
    controller: 'ModelOptionsNext'
    resolve:
      model: \Authentication
      options: -> {}
      period: -> 1
    data: {next: 'home'}
  )

  s (do
    name: 'logout'
    url: '/logout'
    controller: <[Authentication $state]> ++ (auth, state) !->
      auth.logout!
      state.go 'login'

  )

  s (do
    name: 'forgot'
    url: '/forgot-password'
    template-url: 'app/providers/authentication/forgot/forgot.html'
    controller: 'ModelOptionsNext'
    resolve:
      model: \Authentication
      options: -> {}
      period: -> 1
    data: {next: 'forgot-check-email'}
  )

  s (do
    name: 'forgot-check-email'
    url: '/forgot-password/confirmation'
    template-url: 'app/providers/authentication/forgot/check-email.html'
    controller: 'showAndGoAway'
    resolve:
      period: -> 5000
      destination: -> 'login'
  )

  s (do
    name: 'resetpass'
    url: '/auth/reset/:email/:token'
    template-url: 'app/providers/authentication/reset/reset.html'
    controller: 'ModelOptionsNext'
    resolve:
      model: <[Authentication $stateParams]> ++ (auth, sp) ->
        auth.reset-method sp.email, sp.token
      options: -> {}
      period: -> 300
    data: {next: 'resetpassconfirmation'}
  )

  s (do
    name: 'resetpassconfirmation'
    url: '/auth/reset-confirm/'
    template-url: 'app/providers/authentication/reset/confirmation.html'
    controller: 'showAndGoAway'
    resolve:
      period: -> 3000
      destination: -> 'home'
  )
