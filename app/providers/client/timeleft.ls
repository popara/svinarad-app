angular.module "jonny.providers"
.factory "TimeLeft" <[$interval]> ++ ($interval) -> (till, done) ->
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
# .directive "timeLeft" <[TimeLeft]> ++ (TimeLeft) -> (do
#   restrict: 'E'
#   scope:
#     end: \=
#   link: (scope, elem) !->
#     scope.t = TimeLeft
# )
