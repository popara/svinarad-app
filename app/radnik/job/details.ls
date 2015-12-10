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
      options: <[ApplyForJob RemoveApplicationForJob meApplied confirmJobDone confirmpayment resignFromJob]> ++ (a, r, m, jd, cp, res) -> do
        applyforjob: a
        removeapplication: r
        me-applied: m
        confirm-job-done: jd
        confirmpayment: cp
        submit-resign: res
      period: -> 1ms
    data: {next: '.'}
