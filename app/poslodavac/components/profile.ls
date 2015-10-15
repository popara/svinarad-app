angular.module 'svinarad.poslodavac'
.factory 'MyProfile' <[fo AuthUID]> ++ (fo, uid) -> fo "users/#{uid!}"
