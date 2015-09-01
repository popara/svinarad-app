{id, values, concat, find} = require 'prelude-ls'
angular.module "jonny.client"
.config <[$stateProvider $urlRouterProvider stateHelperProvider authenticatedOnly notForAuthenticated]> ++
($state-provider, $url-router-provider, state-helper-provider, authenticatedOnly, notForAuthenticated) !->

  s = state-helper-provider.state

  s (do
    name: 'localexpert'
    url: '/localexpert'
    template-url: 'app/clients/home/local.html'
    controller: <[$scope $location]> ++ ($scope, $location) !->
      $scope.to-signup = ->  window.location.href = "/expert/signup"

  )

  s (do
    name: 'benvenido'
    url: '/benvenido'
    template-url: 'app/clients/home/benvenido.html'
  )

  s (do
    name: 'game'
    url: '/personalize'
    template-url: 'app/clients/game/root.html'
    abstract: true
    controller: 'ItemModel'
    resolve:
      item: '$stateParams'
  )

  s (do
    name: 'venue'
    url: '/venue/:id'
    template-url: 'app/clients/venue/venue.html'
    restrict: authenticatedOnly
    controller: 'Model'
    resolve:
      model: <[$stateParams Plan Expert]> ++ (sp, p, exp) ->
        id = sp.id
        plan <- p.$loaded!then
        e <- exp.then
        do
          entry: (find (-> it[id]), values plan.categories)[id]
          expert: e
  )

  s (do
    name: 'category'
    url: '/category/:id'
    template-url: 'app/clients/plan/category/category.html'
    controller: 'ModelOptionsNext'
    resolve:
      model: <[$stateParams Plan]> ++ (sp, p) ->
        console.log \cekam sp.id, p
        <- p.$loaded
        p.categories[sp.id]
      options: <[$stateParams CategoriesObject]> ++ (sp, co) -> co.$loaded -> co[sp.id]
      period: -> 5
    data: {next: '', -inject}
  )

  $url-router-provider.otherwise '/personalize/0'
