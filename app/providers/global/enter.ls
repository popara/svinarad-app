angular.module "jonny.providers"
.directive "ngEnter" -> (do
  restrict: 'A'
  link: (scope, elem, attrs) !->
    event <-! elem.bind "keydown keypress"
    if event.which === 13
      scope.$apply !-> scope.$eval attrs.ngEnter
      event.prevent-default!
)
