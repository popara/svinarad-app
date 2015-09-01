{sort-by, concat-map, sum, reverse, empty, filter, last, head, map, each, elem-index} = require 'prelude-ls'
angular.module "jonny.admin"
.factory 'ClientRoom' <[fa unseenByUser AuthUID Client]> ++ (fa, unseen, uid, client) -> (user) -> fa "chat/#{user}/us" (do
  id: -> user
  last-message: -> head @.$list
  client: -> client user
)
.factory 'ChatShout' <[AuthUID timestamp]> ++ (me, timestamp) -> (do
    shout: (room, what) -> let user-id = me!, now = timestamp!
      msg = (do
        what: what
        who: user-id
        at: now
        seen: {}
      )
      msg.seen[user-id] = now

      room.$add msg
)
.factory "ChatRoot" <[fo]> ++ (fo) -> fo "chat"

.factory 'AllChats' <[AllClientsRooms unseenByUser AuthUID ChatRoot]> ++ ((acr, unseen, uid, ChatRoot) -> let me = uid!
  prep = (rooms) ->

    rooms |>
    map ( (i) ->
      i.unread = unseen i.chat-room, me
      i
    )
    |> sort-by (.unread)
    |> reverse

  model =
    chats: []

  rooms = []
  prep-rooms = -> model.chats = prep rooms
  acr.then (rs) ->
    rooms := rs
    prep-rooms!

  ChatRoot.$watch prep-rooms

  model
)
.factory 'AllUnseenMessagesCount' <[AllClientsRooms unseenByUser AuthUID]> ++ ((acr, unseen, uid) -> -> let me = uid!
  rooms <- acr.then
  rooms
  |> concat-map (-> (unseen it.chat-room, me).length)
  |> sum
)
.constant 'MrWolfMessage' (name) -> "Hello, #{name} I am Mr. Wolf. I solve your problems. What can I can help you with?"
.config <[stateHelperProvider authenticatedOnly]> ++ (shp, authenticatedOnly) !->
  s = shp.state

  s (do
    name: 'chat-user'
    url: '/chat/user/:id'
    template-url: 'app/admin/chat/chat.html'
    restrict: authenticatedOnly
    controller: 'Model'
    resolve:
      model: <[ClientRoom ChatShout Auth $stateParams User]> ++ (a, b, c, sp, p) ->
        (do
          room: a sp.id
          shout: b.shout
          auth: c.$get-auth!
          cid: sp.id
          client: p sp.id
        )
      see-all: \seeAll

    on-enter: <[model seeAll]> ++ (model, see-all) !->
      <- model.room.$loaded
      see-all model.room, model.auth.uid |>
      each (-> model.room.$save elem-index it, model.room)

  )

  s (do
    name: 'allchats'
    url: '/chat/all'
    template-url: 'app/admin/chat/allchats.html'
    restrict: authenticatedOnly
    controller: <[$scope AllChats]> ++ ($scope, model) ->
      $scope.model = model
  )

.filter 'humanize' -> ->
  t = (parse-int it)
  if t then moment t .from-now! else ''
