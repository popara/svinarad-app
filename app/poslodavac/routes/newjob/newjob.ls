angular.module "svinarad.poslodavac"
.config <[stateHelperProvider authenticatedOnly]> ++ (state-helper-provider, authenticatedOnly) !->
  s = state-helper-provider.state
  s do
    name: 'newjob'
    url: '/novi-posao'
    template-url: 'app/poslodavac/routes/newjob/newjob.html'
