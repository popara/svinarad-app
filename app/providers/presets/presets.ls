{map} = require \prelude-ls
angular.module "jonny.providers"
.config <[stateHelperProvider]> ++ (shp) !->
  s = shp.state

  s (do
    name: 'presets'
    url: '/presets'
    controller: 'ModelOptionsNext'
    template-url: 'app/providers/presets/presets.html'
    resolve:
      model: \Presets
      options: <[cardBuilder bogusMap $state]> ++ (cardBuilder, bogusMap, state)-> do
        createCard: cardBuilder
        map: bogusMap
        new-deck: (p) ->
          p.then (ref) !-> state.go 'deck' {id: ref.key!}
      period: ->  10
    data: {}
  )

  s (do
    name: 'deck'
    url: '/deck/:id'
    controller: 'ModelOptionsNext'
    template-url: 'app/providers/presets/decks.html'
    resolve:
      model: <[fo AuthUID $stateParams]> ++ (fo, uid, sp) ->
        fo "presets/#{uid!}/decks/#{sp.id}/" .$loaded!
      options: <[PresetCards fa AuthUID $stateParams $state]> ++ (cards, fa, uid, sp, state) -> let cs = fa "presets/#{uid!}/decks/#{sp.id}/cards/"
        <- cs.$loaded!
        do
          cards: cards
          in: (a) ->
            | a =>
              bs = map (.entry.venue.name), cs
              v = a.entry.venue.name
              v in bs
            | _ => false
          add-card: (card) !-> cs.$add card
          remove-card: (card) !-> cs.$remove card
          delete-it: (model) ->
            model.$remove!then !-> state.go 'presets'

      period: -> 10
    data: {}
  )

.factory "cardBuilder" <[EntryBuilder]> ++ (EntryBuilder) ->
  (category) -> do
    entry: EntryBuilder!
    category: category

.factory "deckBuilder" ->
  (name) -> do
    name: name
    cards: []


.factory 'PresetCards' <[fa AuthUID cardBuilder]> ++ (fa, uid, cb) ->
  fa "presets/#{uid!}/cards" do
    new-card: -> @$add cb ''

.factory "PresetDecks" <[fa AuthUID deckBuilder]> ++ (fa, uid, db) ->
  fa "presets/#{uid!}/decks" do
    new-deck: -> @$add db 'Untitled Deck'

.factory "Presets" <[PresetCards PresetDecks]> ++ (cards, decks) ->
  <- cards.$loaded
  <- decks.$loaded
  {cards, decks}
