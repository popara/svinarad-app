angular.module 'svinarad.radnik'
.config <[stateHelperProvider authenticatedOnly]> ++ (state-helper-provider, authenticatedOnly) !->
  s = state-helper-provider.state

  s do
    name: 'details'
    url: '/posao/{id}'
    controller: 'ModelOptionsNext'
    template-url: 'app/radnik/job/details.html'
    resolve:
      model: <[$stateParams JobById]> ++ (sp, jbid) -> jbid sp.id
      options: <[ApplyForJob RemoveApplicationForJob meApplied]> ++ (a, r, m) -> do
        applyforjob: a
        removeapplication: r
        me-applied: m
      period: -> 1ms
    data: {next: '.'}
