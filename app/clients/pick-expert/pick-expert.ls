{head, filter, map, elem-index, at, last, first, id, sort-by, reverse} = require 'prelude-ls'

angular.module "jonny.client"
.config <[stateHelperProvider authenticatedOnly]> ++ (state-helper-provider, authenticatedOnly) !->
  s = state-helper-provider.state
  s (do
    name: 'pickexpert'
    url: '/pick-expert'
    template-url: 'app/clients/pick-expert/pick-expert.html'
    controller: 'ModelOptionsNext'
    restrict: authenticatedOnly
    resolve:
      model: \MatchedExperts
      options: <[UserProfile]> ++ (p) -> do
        price: 50
        user: p!

      period: -> 50
      state: '$state'
    data: {next: 'order'}
    on-enter: <[options state]> ++ (options, state) !->
      user <- options.user.$loaded
      switch
      | user.payed => state.go 'waiting'
  )

.factory 'MatchedExperts' <[ExpertMatcher PickExpert Experts Users]> ++ (m, picker, es, us) ->
  experts <- es.$loaded!then
  users <- us.$loaded!then
  ids = map (.$id), experts
  picker m filter (.$id in ids), users

.factory "OptedExpert" ->
  x = do
    first_name: 'Luka'
  do
    set: -> x := it
    get: -> x

.factory 'Experts' <[fa]> ++ (fa) -> fa 'experts'
.factory 'PickExpert' <[UserProfile OptedExpert]>  ++ (p, opted) -> ((experts) -> let client = p!
  has-next = (i, xs) -> i+1 < xs.length
  has-prev = (i, xs) -> i-1 > -1

  e-ix = -> elem-index it, experts

  can-next = -> has-next (e-ix m.expert), experts
  can-prev = -> has-prev (e-ix m.expert), experts

  cycle-forward = (i, xs) ->
    ni = i+1
    switch
    | ni < xs.length => xs[ni]
    | otherwise => first xs

  cycle-backward = (i, xs) ->
    ni = i-1
    switch
    | ni > -1 => xs[ni]
    | otherwise => last xs

  weight = 0

  get-next = !->
    m.previous = m.expert
    m.expert = cycle-forward (e-ix m.expert), experts
    weight := weight+1

  get-prev = !->
    m.expert = cycle-backward (e-ix m.expert), experts
    m.previous = if can-prev! then (cycle-backward (e-ix m.expert), experts) else null
    weight := weight-1

  m =
    qualifier: -> switch m.expert
      | head experts => "perfect"
      | _ => "good"

    previous: null
    experts: experts
    expert: first experts
    show-next: get-next
    back: get-prev
    has-next: can-next
    has-prev: can-prev
    pick: (expert) ->
      client.expert = expert.$id
      opted.set expert
      client.$save!
  m
)

.factory 'ExpertMatcher' ->
  reverse << (sort-by (.rating)) << filter (.available)

.factory 'ClientExpert' <[Profile UserProfile]> ++ (P, profile) -> let profile = profile!
  <- profile.$loaded
  expert <- P.id profile.expert .$loaded
  expert
