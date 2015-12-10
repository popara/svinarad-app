angular.module "svinarad.radnik"
.config <[stateHelperProvider authenticatedOnly]> ++ (state-helper-provider, authenticatedOnly) !->
  s = state-helper-provider.state
  s do
    name: 'assigned'
    url: '/obaveze'
    template-url: 'app/radnik/routes/assigned/assigned.html'
    controller: 'AsyncModel'
    resolve:
      model: <[WorkerJobs AuthUID]> ++ (jobs, uid) -> do
        jobs: jobs uid! 
