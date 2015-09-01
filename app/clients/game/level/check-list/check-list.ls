/**
 * User: popara
 * Date: 5/17/15
 * Time: 12:57 AM
 */

{id, sort, last, initial, each} = require 'prelude-ls'
angular.module "jonny.client"
.directive 'gameCheckList' <[Collector]> ++ (col) ->
  do
    restrict: 'E'
    template-url: 'app/clients/game/level/check-list/check-list.html'
    scope:
      question: \=
      delegate: \&
      init: \=
    link: (scope) !->
      company = new col!
      scope.extra = ''
      scope.suggestions = sort scope.question.suggestions.split ','
      scope.labels = id
      scope.add-or-remove = (item) ->
        | company.exists item => company.remove item
        | _ => company.set item

      scope.in-answer = (item) -> item in company.get!

      extra = -> [scope.extra]

      scope.$on \answer !->
        scope.delegate {scope.question, answer: company.get! ++ extra!}
        scope.$emit 'answered'

      scope.$watch (-> company.get!length), !->
        scope.delegate {scope.question, answer: company.get! ++ extra!}

      if scope.init
      then
        v = scope.init.value
        scope.extra = last v
        each company.set, initial v


.factory 'Collector' -> ->
  company = []

  (do
    set: -> company.push it
    remove: -> company := _.without company, it
    exists: -> it in company
    get: -> company
  )
