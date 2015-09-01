angular.module "jonny.providers"
.controller "SidebarCtrl" <[$scope UserProfile Auth]> ++ (scope, user, auth) !->
  auth-data <- auth.$on-auth
  u <- user!$loaded
  scope.user = u
