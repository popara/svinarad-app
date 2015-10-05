angular.module 'svinarad.poslodavac'
.factory 'MyJobs' <[fa AuthUID JobStatus]> ++ (fa, uid) ->
  status-to-farr = (status) -> fa "job/#{status}" .$loaded!
  sts = R.values JobStatus
  prms = R.map status-to-farr, sts

  R.zip-obj sts, prms
