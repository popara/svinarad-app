{empty, take, each, elem-index} = require 'prelude-ls'
take-some = take 50
angular.module "jonny.client"
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
.factory "AgentChatShout" <[Notifications UserProfile ChatShout ClientExpert]> ++ (Notifications, user, shout, ClientExpert) ->
  (room, what) ->
    (do
      ex <- ClientExpert.then
      u <- user!$loaded
      Notifications.user-chat u, ex, take-some what
    )
    shout.shout room, what

.factory "MrWolfRoomShout" <[Notifications UserProfile ChatShout]> ++ (Notifications, user, shout) ->
  (room, what) ->
    (do
      u <- user!$loaded
      Notifications.wolf-chat u, take-some what
    )

    shout.shout room, what

.factory "UnreadChats" <[unseenByUser AuthUID AgentChatRoom OurChatRoom]> ++ (unseen, uid, agent-chat, our-chat) ->
  <- agent-chat.$loaded
  <- our-chat.$loaded
  me = uid!

  ucats =
    us: []
    agent: []
    rooms: (fn) ->
      agent-chat.$watch fn
      our-chat.$watch fn
    update: !~>
      ucats.us =  (unseen our-chat, me).length
      ucats.agent = (unseen agent-chat, me).length

  ucats.rooms ucats.update
  ucats.update!
  ucats

.constant 'MrWolfMessage' (name) -> "Hello, #{name} I am Mr. Wolf. I solve problems. What can I can help you with?"
.config <[stateHelperProvider authenticatedOnly]> ++ (shp, authenticatedOnly) !->
  s = shp.state

  s (do
    name: 'chat-agent'
    url: '/chat/agent'
    template-url: 'app/clients/chat/chat.html'
    restrict: authenticatedOnly
    controller: 'Model'
    resolve:
      model: <[AgentChatRoom AgentChatShout Auth]> ++ (a, b, c) -> {room: a, shout: b, auth: c.$get-auth!}
      see-all: \seeAll

    on-enter: <[model seeAll]> ++ (model, see-all) !->
      <- model.room.$loaded
      see-all model.room, model.auth.uid |>
      each (-> model.room.$save elem-index it, model.room)

  )

  s (do
    name: 'chat-us'
    url: '/chat/us'
    template-url: 'app/clients/chat/chat.html'
    restrict: authenticatedOnly
    controller: 'Model'
    resolve:
      model: <[OurChatRoom MrWolfRoomShout Auth MrWolfMessage timestamp UserProfile]> ++ (a, b, c, wolf, timestamp, user) ->
        (do
          <- a.$loaded!then

          if empty a
          then
            u <- user!$loaded
            a.$add (do
              what: wolf u.first_name
              who: 'simplelogin:1'
              at: timestamp!
            )
        )
        {room: a, shout: b, auth: c.$get-auth!}

      see-all: \seeAll

    on-enter: <[model seeAll]> ++ (model, see-all) !->
      <- model.room.$loaded
      see-all model.room, model.auth.uid |>
      each (-> model.room.$save elem-index it, model.room)

  )

.filter 'humanize' -> ->
  moment (parse-int it) .from-now!
