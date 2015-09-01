/**
 * User: popara
 * Date: 5/15/15
 * Time: 8:06 PM
 */

angular.module "jonny.client"
.directive 'gameDates' ->
  do
    restrict: 'E'
    template-url: 'app/clients/game/level/dates/dates.html'
    scope:
      question: \=
      delegate: \&
      init: \=
    link: (scope) !->
      today = moment 0 'HH'
      dates =
        start: null
        end: null
      for-transport = -> let s = it.start, e = it.end
        do
          start: if s then s.format 'x' else false
          end: if e then e.format 'x' else  false
          flexible: scope.flexible

      none = -> not dates.start and not dates.end
      only-start = -> dates.start and (not dates.end)
      both = -> dates.start and dates.end

      add-date = -> switch
        | none! => dates.start = it
        | only-start! and it.is-before dates.start => dates.start = it
        | only-start! and it.is-after dates.start => dates.end = it
        | both! =>
          dates.start = it
          dates.end = null


      remove-date = ->
        | dates.end => dates.end = null
        | dates.start => dates.start = null

      scope.remove-date = remove-date
      scope.dates = dates
      scope.clicked = (day) !-> add-date day

      scope.highlight = (day) ->
        | dates.start and dates.end =>
          (day.is-between dates.start, dates.end)
          or day.is-same dates.start
          or day.is-same dates.end
        | dates.start => day.is-same dates.start
        | _ => false


      scope.disabled = (day) -> day.is-before today
      scope.flexible = false


      scope.$on \answer !->
        scope.delegate {scope.question, answer: for-transport dates}
        scope.$emit 'answered'

      if scope.init
      then
        v = scope.init.value
        dates.start = moment parse-int v.start
        dates.end = moment parse-int v.end
