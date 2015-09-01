{map, group-by, drop, take, find-index} = require 'prelude-ls'
angular.module "app.base"
.directive 'kalendario' <[kalendario]> ++ (kalendario) ->
  (do
    restrict: 'E'
    template-url: 'app/base/global/directives/kalendario/kalendario.html'

    scope:
      day-click: \&
      day-disabled: \&
      day-highlighted: \&

    link: (scope) !->
      scope.kal = kalendario
      scope.click = (day) -> scope.day-click {day}
      scope.disabled = (day) -> scope.day-disabled {day}
      scope.highlighted = (day) -> scope.day-highlighted {day}
  )

.directive 'day' ->
  (do
    restrict: 'E'
    template-url: 'app/base/global/directives/kalendario/day.html'
    scope:
      day: '='
  )

.factory 'kalendario' ->
  start = moment "2015-07-26"
  end = moment "2015-10-31"


  nuevo-dia = -> it.clone!add 1 'd'

  r = (end, day) ->
    | not day.is-after end, 'day' => [day] ++ r end, nuevo-dia day
    | _ => []


  days = r end, start
  weeks = group-by (.week!), days

  months =
   * label: 'August'
     start-week: 31
   * label: 'September'
     start-week: 36
   * label: 'October'
     start-week: 40


  x-months = map (-> let start = it.start-week, step = 5
    it.weeks = map (weeks.), _.range start, start+step
    it
  )

  mon = x-months months
  active-month = mon.0

  get-active-index = -> find-index (== K.active-month), mon

  K = (do
    labels: moment.weekdays!
    active-month: active-month
    prev: !-> let i = get-active-index!
      K.active-month = mon[i-1]


    next: !-> let i = get-active-index!
      K.active-month = mon[i+1]

    has-prev: -> let i = get-active-index!
      i > 0

    has-next: -> let i = get-active-index!
      i < mon.length-1
  )
  K
