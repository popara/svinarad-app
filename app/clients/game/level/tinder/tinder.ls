angular.module "jonny.client"
.directive 'gameTinder' ->
  do
    restrict: 'E'
    template-url: 'app/clients/game/level/tinder/tinder.html'
    scope:
      question: '='
      delegate: '&'
    link: (scope) !->
      scope.answers = scope.question.suggestions.split ','
      scope.answer = (answer) !-> scope.delegate {answer}




