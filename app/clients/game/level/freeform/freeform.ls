angular.module "jonny.client"
.directive 'gameFreeform' ->
  do
    restrict: 'E'
    template-url: 'app/clients/game/level/freeform/freeform.html'
    scope:
      question: '='
      delegate: \&
      init: \=
    link: (scope) !->
      scope.freetext = ''
      scope.$watch \freetext !->
        scope.delegate {scope.question, answer: scope.freetext}
        
      scope.$on \answer !->
        scope.delegate {scope.question, answer: scope.freetext}
        scope.$emit 'answered'

      if scope.init
      then
        scope.freetext = scope.init.value
