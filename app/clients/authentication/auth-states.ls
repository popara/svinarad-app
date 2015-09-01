/**
 * User: popara
 * Date: 4/23/15
 * Time: 12:21 PM
 */

{id} = require \prelude-ls

angular.module "jonny.client"
.config <[stateHelperProvider]> ++ (state-helper-provider) !->

  s = state-helper-provider.state

  s (do
    name: 'login'
    url: '/login'
    template-url: 'app/clients/authentication/login.html'
    controller: 'ModelOptionsNext'
    resolve:
      model: <[Authentication]> ++ id
      options: -> {}
      period: -> 90000ms
    data: {next:'matching'}
  )

  s (do
    name: 'signup'
    url: '/signup'
    template-url: 'app/clients/authentication/signup.html'
    controller: 'ModelOptionsNext'
    resolve:
      model: \Authentication
      options: \ProfileHelper
      period: -> 15000ms
    data: {next: 'matching' }

  )

  s (do
    name: 'forgot'
    url: '/forgot-password'
    template-url: 'app/clients/authentication/forgot/forgot.html'
    controller: 'ModelOptionsNext'
    resolve:
      model: <[Authentication]> ++ id
      options: -> {}
      period: -> 15000ms
    data: {next: 'forgot-check-email'}

  )

  s (do
    name: 'forgot-check-email'
    url: '/forgot-password/confirmation'
    template-url: 'app/clients/authentication/forgot/check-email.html'
    controller: 'showAndGoAway'
    resolve:
      period: -> 5
      destination: -> 'login'
  )

  s (do
    name: 'reset-password'
    url: '/forgot-password/reset'
    template-url: 'app/clients/authentication/forgot/check-email.html'
    controller: 'showAndGoAway'
    resolve:
      period: -> 5
      destination: -> 'login'
  )
