angular.module 'app.base'
.factory 'MyProfile' <[AuthUID fo]> ++ (uid, fo) -> fo "users/#{uid!}"
.factory 'MiniProfile' <[MyProfile]> ++ (p) -> ->
  p.$loaded -> {p.name, p.$id, p.rating, p.avatar}
