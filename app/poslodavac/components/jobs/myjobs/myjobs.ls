angular.module 'svinarad.poslodavac'
.factory 'MyJobs' <[$fa FF AuthUID JobStatus]> ++ (fa, FF, uid, JobStatus) ->
  (fa <| FF "jobs" .order-by-child 'employer_id' .equal-to uid!)
  
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
