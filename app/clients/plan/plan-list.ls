angular.module "jonny.client"
.directive "planListing" -> (do
  restrict: 'E'
  template-url: 'app/clients/plan/plan-list.html'
  scope:
    model: '='
  controller: <[$scope Organizers]> ++ (scope, options) !->
    ops <- options.then
    scope.options = ops



)
