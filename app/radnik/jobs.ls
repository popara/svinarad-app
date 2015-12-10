{filter, keys} = require 'prelude-ls'

angular.module 'svinarad.radnik'

.factory 'WorkerJobs' <[$fa FF]> ++ (fa, ff) ->
  (id) ->
    fa <| ff \jobs .order-by-child 'worker_id' .equal-to id

.factory 'DoneJobs' <[AuthUID JobByStatus JobStatus]> ++ (uid, jobsbystatus, js) ->
  is-w = (uid, j) --> uid is j.worker_id
  f = filter (is-w uid!)
  wd <- jobsbystatus js.workdone .$loaded
  wp <- jobsbystatus js.workerpayed .$loaded

  (f wd) ++ (f wp)

.factory 'ApplyForJob' <[AuthUID MiniProfile]> ++ (uid, profile) ->
  add-applicant = (id, profile, applicants) ->
    applicants[id] = profile
    applicants

  (job) ->
    p <- profile!then
    job.applicants = add-applicant uid!, p, (job.applicants or {})
    job.$save!

.factory 'RemoveApplicationForJob' <[AuthUID]> ++ (uid) ->
  (job) ->
    delete job.applicants[uid!]
    job.$save!

.factory 'confirmJobDone' <[AuthUID JobStatus timestamp]> ++ (uid, js, now) ->
  (job) ->
    job.percentage = 100
    job.status = js.workdone
    job.timers.work_done = now!
    job.$save!

.factory 'confirmpayment' <[AuthUID JobStatus userReview timestamp]> ++ (uid, js, ur, now) ->
  (job, review) ->
    <- ur uid!, job.employer_id, job.$id, review .then
    job.status = js.finished
    job.timers.closed = now!
    job.$save!

.factory 'cancelReason' <[timestamp]> ++ (now) ->
  (why) -> {why, when: now!}
.factory 'resignFromJob' <[AuthUID JobStatus cancelReason]> ++ (uid, js, cr) ->
  (job, reason) -> let r = R.from-pairs [[uid!, cr reason]]
    job.worker_cancelations = R.merge job.worker_cancelations, r
    delete job.worker
    delete job.worker_id
    job.status = js.open
    job.$save!
