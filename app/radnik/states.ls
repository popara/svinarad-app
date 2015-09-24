angular.module "svinarad.radnik"
.config <[stateHelperProvider $urlRouterProvider authenticatedOnly]> ++ (state-helper-provider, $url-router-provider, authenticatedOnly) !->
  s = state-helper-provider.state

  s do
    name: 'intro'
    url: '/dom'
    template-url: 'app/radnik/intro/intro.html'
    controller: 'Model'
    resolve:
      model: 'Intro'

  s do
    name: 'details'
    url: '/posao/{id}'
    controller: 'ModelOptionsNext'
    template-url: 'app/radnik/job/details.html'
    resolve:
      model: <[$stateParams JobById]> ++ (sp, jbid) -> jbid sp.id
      options: <[ApplyForJob meApplied]> ++ (a, m) -> do
        applyforjob: a
        me-applied: m
      period: -> 1ms
    data: {next: '.confirmation'}
    children:
      * name: 'confirmation'
        url: '/potvrda'
        template-url: 'app/radnik/job/application-confirmation.html'
      ...



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

  $url-router-provider.otherwise '/dom'
