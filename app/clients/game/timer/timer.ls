angular.module "jonny.client"
.factory 'RemainingTime' -> (do
  time: 90
)

.directive 'gameTimer' <[$interval RemainingTime]> ++ ($interval, RemainingTime) ->
  do
    restrict: 'E'
    template-url: 'app/clients/game/timer/timer.html'
    link: (scope, elem) !->
      scope.left = RemainingTime.time
      int = $interval (!-> switch
        | scope.left > 0 => scope.left --
        | otherwise => $interval.cancel int
      ), 1000

.filter 'minutize' -> (value) ->

  w-zero = -> switch
    | it > 10 => it
    | otherwise => "0#{it}"

  dur = moment.duration (parse-int value), \seconds
  "#{w-zero dur.minutes!}:#{w-zero dur.seconds!}"
