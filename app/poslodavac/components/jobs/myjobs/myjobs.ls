angular.module 'svinarad.poslodavac'
.factory 'MyJobs' <[$fa Firefire AuthUID JobStatus]> ++ (fa, FF, uid, JobStatus) ->
  status-to-farr = (uid, status) --> (fa <| FF "jobs/#{status}" .order-by-child 'employer_id' .equal-to uid ).$loaded!
  mapf = status-to-farr uid!

  sts = R.values JobStatus
  prms = R.map mapf, sts

  R.zip-obj sts, prms
