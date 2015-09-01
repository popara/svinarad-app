/**
 * User: popara
 * Date: 4/14/15
 * Time: 2:13 PM
 */
{initial, last} = require 'prelude-ls'

angular.module "jonny.client"
.directive 'gameBingo' ->
  do
    restrict: 'E'
    template-url: 'app/clients/game/level/bingo/bingo.html'
    scope:
      question: '='
      delegate: '&'
      init: '='

    link: (scope) !->
      scope.answer = []
      scope.extra = ''
      scope.answers = scope.question.suggestions.split ','
      scope.selected = (opt) -> opt in scope.answer
      scope.toggle = (opt) !->
        if opt in scope.answer
        then scope.answer = _.without scope.answer, opt
        else scope.answer = scope.answer ++ [opt]


      extra = -> [scope.extra]

      scope.$on \answer !->
        scope.delegate {scope.question, answer: scope.answer ++ extra!}
        scope.$emit 'answered'

      if scope.init
      then
        v = scope.init.value
        scope.extra = last v
        scope.answer = initial v 
