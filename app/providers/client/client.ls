{concat-map, map, filter, find, group-by, values} = require "prelude-ls"
_ = require \prelude-ls

angular.module "jonny.providers"
.config <[stateHelperProvider authenticatedOnly]> ++ (shp, authenticatedOnly) !->
  s = shp.state

  s (do
    name: 'client'
    url: '/client/:id'
    template-url: 'app/providers/client/client.html'
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
      options: <[Categories GameQuestions bogusMap]> ++ (cats, quests, bmap) ->
        categories <- cats.$loaded
        questions <- quests.then
        {categories, questions, map: bmap}
      period: -> 20
    data: {next: ''}
  )

  s (do
    parent: 'client'
    name: 'adddeck'
    url: '/deck'
    template-url: 'app/providers/client/presets/add-deck.html'
    controller: <[$scope decks apply $state]> ++ ($scope, decks, appl, $state) !->
      $scope.decks = decks
      $scope.apply-deck = (deck, plan) !->
        if confirm "Are you sure you want to place #{deck.name} onto clients plan?"
        then
          <- appl deck, plan .then
          $state.go '^'
    resolve:
      decks: \PresetDecks
      apply: \ApplyDeckOnPlan
  )

  s (do
    parent: 'client'
    name: 'addcard'
    url: '/card'
    template-url: 'app/providers/client/presets/add-card.html'
    controller: <[$scope cards apply check]> ++ ($scope, cards, appl, check) !->
      $scope.cards = cards
      $scope.apply-card = appl
      $scope.card-in-plan = check
    resolve:
      cards: \PresetCards
      apply: \ApplyCardOnPlan
      check: \CardInPlan
  )

.factory "bogusMap" -> (do
  center:
    latitude: 38.964214
    longitude: 1.15
  zoom: 10
)
.factory "ApplyDeckOnPlan" -> ((deck, plan) ->
  mapes = -> map (.entry), it
  map-entries = _.Obj.map mapes
  cards = values deck.cards
  plan.categories = cards
    |> group-by (.category)
    |> map-entries

  plan.$save!
)
.factory "ApplyCardOnPlan" -> ((card, plan) ->
  if not plan.categories
  then plan.categories = {}

  if not plan.categories[card.category]
  then plan.categories[card.category] = []

  plan.categories[card.category].push card.entry
  plan.$save!
)
.factory "CardInPlan" -> (card, plan) -> let cat = card.category
  switch
  | plan and plan.categories and plan.categories[cat] => let categ = plan.categories[cat]
    venues = map (.venue.name), categ
    card.entry.venue.name in venues
  | _ => false
