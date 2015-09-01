angular.module "app.base"
.directive "stars" -> (do
  restrict: 'E'
  template-url: 'app/base/global/directives/rating/rating.html'
  scope:
    stars: '='
  link: (scope) !->
    scope.range = -> _.range 1 it+1

)
