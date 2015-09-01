{id, concat-map, head, map, find, keys, values, filter, obj-to-pairs, find-index} = require 'prelude-ls'

angular.module "jonny.client"
.factory 'Levels' <[$firebaseArray Firefire]> ++ (fire-array, F) ->
  fire-array (F \levels .order-by-priority!)
.factory 'Answers' <[fa]> ++ (fa) -> (id) -> fa "answers/#{id}"
.factory "Whishes" <[fo]> ++ (fo) -> (id) -> fo "answers/#{id}"
.factory 'buildLevel' -> ($priority, name, desc, questions) -> {name, desc, questions, $priority}
.factory 'buildAnswer' -> (question, value) -> {question, value}
.factory 'buildQuestion' -> ($priority, name, type, text, suggestions, category) -> {label:name, name, type, text, suggestions, category, $priority}
.factory 'LevelMaster' <[Whishes timestamp SemiAnonAuth]> ++ (Whishes, timestamp, SemiAnonAuth) ->
  as = null
  auth <- SemiAnonAuth.get!then
  as := Whishes auth.uid
  <-  as.$loaded
  answer = (question, value) ->
    as[question.$id] = do
      value: value
      at: timestamp!
    as.$save!

  (do
    answer: answer
    pre-answered: (id) -> as[id]
  )

.factory 'GameQuestions' <[Levels  mapToValues]> ++ (Levels, map-to-values) ->
    levels <- Levels.$loaded!then
    qs = map (.questions), levels
    concat-map map-to-values, qs

.config <[$urlRouterProvider stateHelperProvider]> ++ (url-router, shp) !->
  url-router.when '/game' '/game/0'

  s = shp.state
  s (do
    name: 'game-over'
    url: '/game/over'
    template-url: 'app/clients/game/complete.html'
    controller: 'showAndGoAway'
    resolve:
      period: -> 4000
      destination: -> 'matching'
  )
  s (do
    name: 'question'
    url: '/:num'
    parent: 'game'
    template-url: 'app/clients/game/level/level.html'
    controller: <[$scope model $state]> ++ ($scope, model, $state) !->
      $scope.model = model
      $scope.next = ->
        $scope.$broadcast 'answer'

      $scope.$on \answered !-> switch
        | model.this-is-boss-level => $state.go 'game-over'
        | _ => $state.go 'game.question' {num: model.next}

    resolve:
      model: <[LevelMaster GameQuestions $stateParams]> ++ (lmp, qs, sp) -> let index = parse-int sp.num
        lm <- lmp.then
        questions <- qs.then
        boss-comming = index+2 >= questions.length && (index+1 != questions.length)
        boss-level = index+1 >= questions.length
        label-text = switch
          | boss-comming => 'And last question ...'
          | boss-level => 'YOU ARE DONE! :)'
          | _ => 'Next'

        (do
          q: questions[index]
          init-ans: lm.pre-answered questions[index].$id
          answer: lm.answer
          next: index+1
          boss-level-comming: boss-comming
          this-is-boss-level: boss-level
          index: index
          label-text: label-text
        )
  )
