angular.module 'svinarad.poslodavac'
.factory 'MyJobs' <[$fa Firefire AuthUID JobStatus]> ++ (fa, FF, uid, JobStatus) ->
  mapf = (jobs, status) -->
    jobs
    |> R.filter (.status is status)

  sts = R.values JobStatus
  jobs <- (fa <| FF "jobs" .order-by-child 'employer_id' .equal-to uid! ).$loaded
  R.zip-obj sts <| R.map (mapf jobs), sts


.factory 'PickWorker' <[JobStatus]> ++ (js) ->
  (job, applicant, id) ->
    job.worker = applicant
    job.worker_id = id
    job.status = js.drafted
    job.$save!

.factory 'reviewWorker' <[userReview AuthUID JobStatus]> ++ (ur, uid, js) ->
  (job, worker_id, review) ->
    <- ur uid!, worker_id, job.$id, review .then
    job.status = js.workerpayed
    job.$save!

.factory 'dismissWorker' <[userReview AuthUID JobStatus]> ++ (ur, uid, js) ->
  (job, worker_id, review) ->
    <- ur uid!, worker_id, job.$id, review .then
    job.status = js.open
    delete job.worker
    delete job.worker_id

    job.$save!
