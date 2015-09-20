angular.module 'app.base'
.factory 'JobByStatus' <[$fa FF]> ++ (fa, ff) ->
  (status) -> fa (ff 'jobs' .order-by-child 'status' .equal-to status)
.factory 'JobsByEmployer' <[$fa FF]> ++ (fa. ff) ->
  (uid) -> fa (ff 'jobs' .order-by-child 'employer' .equal-to uid)
.factory 'JobsByWorker' <[$fa FF]> ++ (fa, ff) ->
  (uid) -> fa (ff 'jobs' .order-by-child 'worker' .equal-to uid)
.factory 'OpenJobs' <[JobByStatus JobStatus]> ++ (jbs, js) ->
  jbs js.open
.factory 'JobById' <[$fo FF]> ++ (fo, ff) ->
  (id) -> fo <| ff "jobs/#{id}"
