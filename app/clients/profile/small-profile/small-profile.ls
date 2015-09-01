angular.module "jonny.client"
.directive 'smallProfile' ->
  do
    restrict: 'E'
    template-url: 'app/clients/profile/small-profile/small-profile.html'
    scope:
      profile: '='
      unseen: '=?'
