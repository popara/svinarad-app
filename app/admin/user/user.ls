angular.module "jonny.admin"
.directive "travelerProfile" <[QandA]> ++ (qa) -> (do
  restrict: 'E'
  template-url: 'app/admin/user/traveler-profile.html'
  scope:
    user: \=
  link: (scope, elem) !->
    user <- scope.user.$loaded
    ans <- scope.user.answers!$loaded
    scope.qa = qa ans
)

.directive "jonnyProfile" -> (do
  restrict: 'E'
  template-url: 'app/admin/user/jonny-profile.html'
  scope:
    user: \=
)
