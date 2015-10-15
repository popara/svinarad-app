angular.module 'svinarad.poslodavac'
.config <[stateHelperProvider authenticatedOnly]> ++ (state-helper-provider, authenticatedOnly) !->
  s = state-helper-provider.state
  s do
    name: 'app'
    url: '/app'
    abstract: true
    template-url: 'app/poslodavac/routes/app/app.html'
    restrict: authenticatedOnly
    controller: \AsyncModel
    resolve:
      model: <[MyProfile MyJobs]> ++ (profile, my-jobs) ->
        R.merge {profile: profile.$loaded!}, my-jobs
