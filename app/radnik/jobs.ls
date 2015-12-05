{filter, keys} = require 'prelude-ls'

angular.module 'svinarad.radnik'

.factory 'AppliedJobs' <[AuthUID JobByStatus JobStatus]> ++ (uid, jobsbystatus, js) ->
  have-applied = (uid, j) --> uid in keys j.applicants

  jbs <- jobsbystatus js.open .$loaded
  filter (have-applied uid!), jbs

.factory 'AssignedJobs' <[AuthUID JobByStatus JobStatus]> ++ (uid, jobsbystatus, js) ->
  is-assigned = (uid, j) --> uid is j.worker_id

  jbs <- jobsbystatus js.drafted .$loaded
  filter (is-assigned uid!), jbs


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

.factory 'confirmJobDone' <[AuthUID JobStatus]> ++ (uid, js) ->
  (job) ->
    job.percentage = 100
    job.status = js.workdone
    job.$save!

.factory 'confirmpayment' <[AuthUID JobStatus userReview]> ++ (uid, js, ur) ->
  (job, review) ->
    <- ur uid!, job.employer_id, job.$id, review
    job.status = js.finished
    job.$save! 
