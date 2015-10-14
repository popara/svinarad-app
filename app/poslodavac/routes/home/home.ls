angular.module "svinarad.poslodavac"
.config <[stateHelperProvider $urlRouterProvider authenticatedOnly]> ++ (state-helper-provider, $url-router-provider, authenticatedOnly) !->
  s = state-helper-provider.state

  s do
    name: 'home'
    url: '/'
    template-url: 'app/poslodavac/routes/home/home.html'
    restrict: authenticatedOnly
    controller: \AsyncModel
    resolve:
      model: <[MyProfile MyJobs]> ++ (profile, my-jobs) ->
        R.merge {profile: profile.$loaded!}, my-jobs

.factory 'MyProfile' <[fo AuthUID]> ++ (fo, uid) -> fo "users/#{uid!}"
