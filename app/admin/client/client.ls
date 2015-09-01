angular.module "jonny.admin"
.config <[stateHelperProvider authenticatedOnly]> ++ (shp, authenticatedOnly) !->
  s = shp.state

  s (do
    name: 'client'
    url: '/client/:id'
    template-url: 'app/admin/client/client.html'
    restrict: authenticatedOnly
    controller: 'ModelOptionsNext'
    resolve:
      model: <[Client $stateParams ClientDetails QandA]> ++ ((client, sp, cd, qa) ->
        cl <- client sp.id .$loaded
        ans <- cl.answers!$loaded
        plan <- cl.plan!$loaded
        x = cd ans
        dates = x.dates!

        (do
          client: cl
          answers: ans
          plan: plan
          details: x
          dates: dates
          qa: qa ans
          t: x.timeleft plan
        )
      )
      options: <[Categories GameQuestions]> ++ (cats, quests) ->
        categories <- cats.$loaded
        questions <- quests.then
        {categories, questions}
      period: -> 20
    data: {next: ''}

  )
