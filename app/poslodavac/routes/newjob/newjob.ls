angular.module "svinarad.poslodavac"
.config <[stateHelperProvider authenticatedOnly]> ++ (state-helper-provider, authenticatedOnly) !->
  s = state-helper-provider.state
  s do
    name: 'newjob'
    url: '/novi-posao'
    template-url: 'app/poslodavac/routes/newjob/newjob.html'
    parent: 'home'
    controller: 'ModelOptionsNext'
    resolve:
      model: <[NewJob MiniProfile]> ++ (nj, profile) ->
        p <- profile!then
        nj p
      options: <[Jobs datetime]> ++ (J, now) -> do
        submit: (job) ->
          job.timers.published = now!
          J.$add job
      period: -> 100ms
    data: {next: 'home'}
