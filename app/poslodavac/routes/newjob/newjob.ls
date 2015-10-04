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

.factory 'NewJob' <[JobStatus]> ++ (status)->
  (profile) ->
    do
      status: status.open
      title: 'Zamena sizifa'
      percentage: 0
      employer: profile
      description: 'pakleni posao za djavola samog'
      credits: 0
      success_condition: 'nema ga, uvek ces raditi'
      final_instructions: 'radiiii'
      total_working_hours: 'punooo'
      working_period: 'Od jutra od sutra'
      timers:
        published: ''
        work_done: ''
        closed: ''
      location:
        text: 'Dummy mesto'
        geo:
          lat: 0
          lng: 0
      applicants: {}
