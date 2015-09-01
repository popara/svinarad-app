/**
 * User: popara
 * Date: 5/15/15
 * Time: 5:16 PM
 */
{map, pairs-to-obj} = require 'prelude-ls'

angular.module "jonny.client"
.factory "Peoples" -> [
  ["me" "Me"]
  ["yourpartner" "Your Partner"]
  ["malefriends" "Male friend (s)"]
  ["femalefriends" "Female friend (s)"]
  ["kids" "Kids"]
  ["yourparents" "Your parents"]
  ["pets" "Pets"]
  ["others" "Others"]
]

.directive 'gameCompanyDetails' <[Company Peoples]> ++ (Company, peoples) ->
  do
    restrict: 'E'
    template-url: 'app/clients/game/level/company-details/company-details.html'
    scope:
      question: \=
      delegate: \&
      init: \=
    link: (scope, elem) !->
      company = Company.get!
      scope.c = pairs-to-obj map (-> [it.0, it.1 in company]), peoples
      scope.a.partner = "yourpartner" in company

      scope.$on \answer !->
        scope.delegate {scope.question, answer: scope.a}
        scope.$emit 'answered'

      if scope.init
      then
        v = scope.init.value
        _.merge scope.a, v
