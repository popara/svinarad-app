angular.module "svinarad.poslodavac"
.config <[stateHelperProvider authenticatedOnly]> ++ (state-helper-provider, authenticatedOnly) !->
  s = state-helper-provider.state
  s do
    parent: 'app'
    name: 'job'
    url: '/job/:id/:s'
    template-url: 'app/poslodavac/routes/job/job.html'
    controller: 'AsyncModel'
    resolve:
      model: <[JobById $stateParams]> ++ (j, sp) -> do
        job: (j sp.s, sp.id ).$loaded!
