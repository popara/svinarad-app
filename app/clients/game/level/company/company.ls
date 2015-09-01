{find, id, keys, each, map} = require 'prelude-ls'
angular.module "jonny.client"
.directive 'gameCompany' <[Peoples Company Profile LevelMaster]> ++ (peoples, company, Profile, lmp) ->
  do
    restrict: 'E'
    template-url: 'app/clients/game/level/company/company.html'
    scope:
      question: \=
      delegate: \&
      init: \=
    link: (scope, elem) !->
      l = -> switch it
        | "partner" => "yourpartner"
        | _ => it

      details = \details
      scope.suggestions = scope.question.suggestions.split ','
      scope.labels = id
      scope.add-or-remove = (item) ->
        | company.exists item => company.remove item
        | _ => company.set item

      scope.in-answer = (item) -> item in company.get!
      scope.$on \answer !-> scope.$emit 'answered'

      company.set \Me

      lm <- lmp.then
      init = lm.pre-answered '-JqBllrWbGFREdmbYTMt'
      if init
      then
        v = init.value

        x =
          _.without (keys v), details
          |> map l
          |> map ((a) -> find (-> it.0 == a), peoples)
          |> map (-> it.1)

        each company.set, x


.factory 'Company' ->
  company = []

  (do
    set: -> company.push it
    remove: -> company := _.without company, it
    exists: -> it in company
    get: -> company
  )
