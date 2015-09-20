angular.module 'svinarad.radnik'
.factory 'JobDetail' <[JobById $stateParams]> ++ (JobById, sp) ->
  console.log sp
  do
    job <- JobById sp.jobid .$loaded
    console.log job
    jds.job = job

  jds =
    job: {}
