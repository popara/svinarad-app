{id, keys, values} = require \prelude-ls
angular.module "jonny.admin"
.factory "TimeLeft" <[$interval]> ++ ($interval) -> ((till, done) ->
  left = (to, from) --> moment.duration to.diff from

  checkf = left till
  a =
    timeleft: checkf moment!

  check-timeleft = !->
    now = moment!


    if now.is-before till
    then a.timeleft =  checkf now
    else
      done!
      $interval.cancel i

  i = $interval check-timeleft, 1000

  a
)
.directive "timeLeft" <[TimeLeft]> ++ (TimeLeft) -> (do
  restrict: 'E'
  scope:
    end: \=
  link: (scope, elem) !->
    scope.t = TimeLeft scope.end
    console.log scope.end
)
.directive "planTimeLeft"  <[TimeLeft $filter]> ++ (timeLeft, $f ) -> (do
  restrict: 'E'
  template: '<div ng-show="t">{{ t.timeleft.get("hours") }}h : {{ t.timeleft.get("minutes") }}m </div>'
  scope:
    plan: \=
  link: (scope) !-> let plan = scope.plan, to-moment = $f \toMoment
    if plan
    then
      <- plan.$loaded
      if plan.delivery
      then
        scope.t = timeLeft (to-moment plan.delivery), id
)
