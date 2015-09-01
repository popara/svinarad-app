angular.module "app.base"
.directive "face" -> (do
  restrict: 'E'
  scope:
    id: '='
  link: (scope, elem) !->
    urlit = -> "url('/img/users/#{it}.jpg')"
    scope.$watch 'id' !->
      | scope.id => elem.css {background-image: urlit scope.id}
)
