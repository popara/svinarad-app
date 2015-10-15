angular.module "svinarad.poslodavac"
.config <[stateHelperProvider authenticatedOnly]> ++ (state-helper-provider, authenticatedOnly) !->
  s = state-helper-provider.state
  s do
    parent: 'app'
    name: 'newjob'
    url: '/novi-posao'
    template-url: 'app/poslodavac/routes/newjob/newjob.html'
    controller: 'ModelOptionsNext'
    resolve:
      model: <[NewJob AuthUID MyProfile]> ++ (nj, uid, profile) ->
        p <- profile.$loaded!then
        nj.spawn uid!, p
      options: <[NewJob datetime]> ++ (J, now) -> do
        submit: (job) ->
          J.save job
      period: -> 100ms
    data: {next: '^.home'}
