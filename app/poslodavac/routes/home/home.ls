angular.module "svinarad.poslodavac"
.config <[stateHelperProvider $urlRouterProvider authenticatedOnly]> ++ (state-helper-provider, $url-router-provider, authenticatedOnly) !->
  s = state-helper-provider.state

  s do
    parent: 'app'
    name: 'home'
    url: '/home'
    template-url: 'app/poslodavac/routes/home/home.html'
    restrict: authenticatedOnly
    controller: \AsyncModel
    resolve:
      model: <[MyProfile MyJobs]> ++ (profile, my-jobs) ->
        R.merge {profile: profile.$loaded!}, {jobs: my-jobs}


  $url-router-provider.otherwise '/app/home'

.config <[visorProvider]> ++ (visorProvider) !->
  visorProvider.home-route = '/app/home'
