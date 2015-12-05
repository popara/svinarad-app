angular.module "svinarad.radnik"
.config <[stateHelperProvider authenticatedOnly]> ++ (state-helper-provider, authenticatedOnly) !->
  s = state-helper-provider.state
  s do
    name: 'uncleared'
    url: '/gotovi'
    template-url: 'app/radnik/routes/uncleared/uncleared.html'
    controller: 'AsyncModel'
    resolve:
      model: <[DoneJobs]> ++ (dj) -> do
        jobs: dj
