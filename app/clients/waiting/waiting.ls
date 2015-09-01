angular.module "jonny.client"
.factory "waitingRoom" <[Plan UnreadChats  Expert]> ++ (plan, unseen, expert-p) ->
  expert <- expert-p.then
  uchats <- unseen.then
  wr =
    expert: expert
    unseen: uchats

  wr

.config <[stateHelperProvider authenticatedOnly]> ++ (shp, authenticatedOnly) !->
  s = shp.state
  s (do
    name: 'waiting'
    url: '/waiting?fr'
    template-url: 'app/clients/waiting/waiting.html'
    controller: 'ConditionAndGo'
    resolve:
      condition: <[Plan]> ++ (p) -> -> p.ready
      next: -> 'plan'
      model: \waitingRoom
  )

.directive "waitingPlan" <[TimeLeft Plan]> ++ (TimeLeft, Plan) -> (do
  restrict: 'E'
  template-url: 'app/clients/waiting/counting.html'
  scope:
    done: \&
  link: (scope, elem) !->
    <-! Plan.$loaded
    end = moment parse-int Plan.delivery
    t = TimeLeft end, !-> scope.done!
    scope.t = t
)

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
