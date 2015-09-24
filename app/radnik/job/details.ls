angular.module 'svinarad.radnik'
.factory 'JobDetail' <[JobById $stateParams]> ++ (JobById, sp) ->
  do
    job <- JobById sp.jobid .$loaded
    jds.job = job

  jds =
    job: {}
