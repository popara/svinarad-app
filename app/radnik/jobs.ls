{filter, keys} = require 'prelude-ls'

angular.module 'svinarad.radnik'

.factory 'AppliedJobs' <[AuthUID JobByStatus JobStatus]> ++ (uid, jobsbystatus, js) ->
  have-applied = (uid, j) --> uid in keys j.applicants
  jbs <- jobsbystatus js.open .$loaded
  filter (have-applied uid!), jbs

.factory 'AssignedJobs' <[AuthUID JobByStatus JobStatus]> ++ (uid, jobsbystatus, js) ->
  is-assigned = (uid, j) --> uid is j.worker
  jbs <- jobsbystatus js.drafted .$loaded
  filter (is-assigned uid!), jbs
