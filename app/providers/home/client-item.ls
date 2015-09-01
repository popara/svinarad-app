angular.module "jonny.providers"
.directive "clientItem" <[ClientDetails]> ++ (CD) -> (do
  restrict: 'E'
  template-url: 'app/providers/home/client-item.html'
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
