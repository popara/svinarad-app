angular.module "svinarad.poslodavac"
.config <[stateHelperProvider $urlRouterProvider authenticatedOnly]> ++ (state-helper-provider, $url-router-provider, authenticatedOnly) !->
  s = state-helper-provider.state

  s do
    name: 'home'
    url: '/'
    template-url: 'app/poslodavac/routes/home/home.html'
    restrict: authenticatedOnly
    controller: \Model
    resolve:
      model: \MyProfile

.factory 'MyProfile' <[fo AuthUID]> ++ (fo, uid) -> fo "users/#{uid!}"
