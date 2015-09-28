angular.module 'svinarad.poslodavac'
.factory 'CreatedJobs' <[AuthUID JobsByEmployer]> ++ (uid, jobs) -> jobs uid .$loaded!
