angular.module 'svinarad.poslodavac'
.factory 'NewJob' <[JobStatus fa datetime]> ++ (status, fa, now) ->
  spawn = (owner-id, profile) ->
    do
      status: status.draft
      title: 'Zamena sizifa'
      percentage: 0
      employer_id: owner-id
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

  save = (job) ->
    if job.status is status.open
    then job.timers.published = now!
    console.log 'add' job.title 
    fa "jobs" .$add job

  save-w-promise = R.head << save

  {spawn, save, save-w-promise}
