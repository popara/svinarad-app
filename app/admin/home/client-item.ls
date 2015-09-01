{values, is-type, sum, compact, map} = require \prelude-ls
angular.module "app.base"
.factory "ClientDetails"  <[TimeLeft AnswerOnQuestion]> ++ (TimeLeft, ANS) ->
  (answers) ->
    s = ANS answers
    (do
      timeleft: (plan) ->
        end = moment parse-int plan.delivery
        TimeLeft end, !->
      dates: -> s 'dates'
      totalpeople: ->
        values s 'company-details' |>
        map (->
          | is-type 'Object' it => it.count
          | _ => 0
        ) |>
        map parse-int |> compact >> sum
    )
.directive "clientItem" <[ClientDetails]> ++ (CD) -> (do
  restrict: 'E'
  template-url: 'app/admin/home/client-item.html'
  scope:
    client: \=
  link: (scope, elem) !->
    plan <- scope.client.plan!$loaded
    answers <- scope.client.answers!$loaded

    scope.plan = plan
    scope.answers = answers
    x = CD answers
    scope.t = x.timeleft plan
    scope.dates =  x.dates!
    scope.totalpeople = x.totalpeople!
)
