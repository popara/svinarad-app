{keys} = require 'prelude-ls'
angular.module 'svinarad.radnik'
.factory 'Intro' <[OpenJobs FF AuthUID meApplied]> ++ (oj, ff, uid, me-applied) ->
  {oj, me-applied}

.factory 'applied' -> (me, job) --> (R.has 'applicants' job) and (R.has me, job.applicants)
.factory 'meApplied' <[applied AuthUID]> ++ (applied, me) -> applied me!
