/**
 * User: popara
 * Date: 4/9/15
 * Time: 3:12 PM
 */

{id, values, concat, find} = require 'prelude-ls'

angular.module "jonny.admin"
.config <[$stateProvider $urlRouterProvider stateHelperProvider authenticatedOnly notForAuthenticated]> ++
($state-provider, $url-router-provider, state-helper-provider, authenticatedOnly, notForAuthenticated) !->

  name-it = (name, thing) -->
    thing.__name = name
    thing

  name-promise = (name, promise) --> promise.then (result) -> name-it name, result

  s = state-helper-provider.state
  s (do
    name: 'home'
    url: '/'
    template-url: 'app/admin/home/home.html'
    restrict: authenticatedOnly
    controller: 'Model'
    resolve:
      model: 'Home'
  )

  s (do
    name: 'user'
    url: '/user/:id'
    template-url: 'app/admin/user/user.html'
    restrict: authenticatedOnly
    controller: 'Model'
    resolve:
      model: <[User $stateParams Experts]> ++ (user, sp, Experts) -> do
        user: user sp.id
        expert: Experts
        is-expert: -> Experts[sp.id]
  )

  s (do
    name: 'plan'
    url: '/user/:id/plan'
    template-url: 'app/admin/plan/plan.html'
    controller: 'Model'
    resolve:
      model: <[Plan User Categories $stateParams]> ++ (plan, user, categories, sp) -> do
        plan: plan sp.id
        user: user sp.id
        categories: categories



  )

  s (do
    name: 'agent-chat'
    url: '/agent-chat/:id'
    template-url: 'app/admin/chat/chat-readonly.html'
    restrict: authenticatedOnly
    controller: 'Model'
    resolve:
      model: <[UnfocusedChatRoom $stateParams]> ++ (chat, sp) -> do
        room: chat sp.id
        client: sp.id
  )

  s (do
    name: 'login'
    url: '/login'
    template-url: 'app/admin/authentication/login.html'
    controller: 'ModelOptionsNext'
    resolve:
      model: <[Authentication]> ++ id
      options: -> {}
      period: -> 1
    data: {next: 'home'}
  )

  s (do
    name: 'logout'
    url: '/logout'
    controller: 'ModelOptionsNext'
    resolve:
      model: <[Authentication]> ++ id
      options: -> {}
      period: -> 1
    data: {next: 'home'}
  )


  $url-router-provider.otherwise '/'

.config <[$locationProvider]> ++ ($location-provider) !->
  $location-provider.html5-mode true
