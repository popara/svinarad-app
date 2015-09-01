/**
 * User: popara
 * Date: 4/9/15
 * Time: 4:46 PM
 */
{map, concat-map, values, obj-to-pairs, keys, at} = require 'prelude-ls'


angular.module "jonny.client"
.factory 'Plan' <[fo AuthUID]> ++ (fo, uid) -> fo "plan/#{uid!}"
.factory 'PlanHelpers' ( -> do
  count: (it) -> (keys it ).length
)
.factory 'Expert' <[Profile]> ++ (p) ->
   user <- p.get!$loaded!then
   (p.id user.expert)

.factory 'MyAnswers' <[UserProfile fa]> ++ (up, fa) ->
  user <- up!$loaded
  fa "answers/#{user.anon}"

.factory 'Organizers' <[UserProfile Profile CategoriesObject PlanHelpers MyAnswers ClientDetails UnreadChats]> ++ (up, Profile, Categories, PlanHelpers, MyAnswers, Details, UnreadChats) ->
  local-limit = 2
  user <- up!$loaded
  <- Categories.$loaded!then
  answers <- MyAnswers.then
  uc <- UnreadChats.then

  (do
    user: user
    expert: Profile.id user.expert
    categories: Categories
    helpers: PlanHelpers
    details: Details answers
    unread: uc
    local-limit: local-limit
    limited: (category) ->  values category |> at local-limit
  )

.factory 'Categories' <[fa]> ++ (fa) -> fa 'categories'
.factory 'CategoriesObject' <[fo]> ++ (fo) -> fo 'categories'
.factory 'idzer' -> ((obj) ->
  f = ->
    it.1.$id = it.0
    it.1

  map f, obj-to-pairs obj
)

.config <[stateHelperProvider]> ++ (shp) !->
  s = shp.state

  s (do
    name: 'plan'
    url: '/plan'
    template-url: 'app/clients/plan/plan.html'
    controller: <[$scope Plan Organizers]> ++ ($scope, model, options) !->
      $scope.model = model
      $scope.list-or-map = \list
      $scope.toggle = !-> let n = $scope.list-or-map
        $scope.list-or-map = switch n
          | \list => \map
          | _ => \list
        $scope.$broadcast 'TOGGLED'

      opts <- options.then
      $scope.options =  opts

    resolve:
      tmap: \TreasureMap

    on-enter: <[tmap]> ++ (tmap) -> tmap.update!
    on-exit: <[tmap]> ++ (tmap) -> tmap.clear-all!
  )
