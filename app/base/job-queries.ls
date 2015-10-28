angular.module 'app.base'
.factory 'JobByStatus' <[$fa FF]> ++ (fa, ff) ->
  (status) -> fa (ff 'jobs' .order-by-child 'status' .equal-to status)
.factory 'JobsByEmployer' <[$fa FF]> ++ (fa, ff) ->
  (uid) -> fa (ff 'jobs' .order-by-child 'employer/id' .equal-to uid)
.factory 'JobsByWorker' <[$fa FF]> ++ (fa, ff) ->
  (uid) -> fa (ff 'jobs' .order-by-child 'worker' .equal-to uid)
.factory 'OpenJobs' <[JobByStatus JobStatus]> ++ (jbs, js) ->
  jbs js.open
.factory 'JobById' <[$fo FF]> ++ (fo, ff) ->
  (status, id) -> fo <| ff "jobs/#{status}/#{id}"

.factory 'Jobs' <[$fa FF]> ++ (fa, ff) -> fa <| ff 'jobs'
