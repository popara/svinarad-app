angular.module "app.base"
.directive "bgImage" -> (do
  restrict: 'A'
  scope:
    bg-image: \=
  link: (scope, elem, attrs) !->
    urlit = -> "url('#{it}')"
    scope.$watch 'bgImage' ->
      | scope.bg-image => elem.css {background-image: urlit scope.bg-image}
)
