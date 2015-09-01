{empty, filter, last, head, map, each, elem-index, take} = require 'prelude-ls'
take-some = take 50
angular.module "jonny.providers"
.factory 'ClientRoom' <[fa unseenByUser AuthUID Client]> ++ (fa, unseen, uid, client) -> (user) -> fa "chat/#{user}/agent" (do
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
.factory "JonnyShout" <[Notifications ChatShout]> ++ (Notifications, shout) ->
  (client, expert) -> (room, what) ->
    Notifications.jonny-chat client, expert, what
    shout.shout room, what

.factory "MrWolfRoomShout" <[Notifications UserProfile ChatShout]> ++ (Notifications, user, shout) ->
  (room, what) ->
    Notifications.wolf-chat user, take-some what
    shout.shout room, what

.constant 'MrWolfMessage' (name) -> "Hello, #{name} I am Mr. Wolf. I solve problems. What can I can help you with?"
.config <[stateHelperProvider authenticatedOnly]> ++ (shp, authenticatedOnly) !->
  s = shp.state

  s (do
    name: 'chat-user'
    url: '/chat/user/:id'
    template-url: 'app/providers/chat/chat.html'
    restrict: authenticatedOnly
    controller: 'Model'
    resolve:
      model: <[ClientRoom JonnyShout Auth $stateParams Client UserProfile]> ++ (a, b, c, sp, cl, u) ->
        client <- cl sp.id .$loaded
        expert <- u!$loaded
        (do
          room: a sp.id
          shout: b client, expert
          auth: c.$get-auth!
          client: sp.id
          other: client
        )
      see-all: \seeAll

    on-enter: <[model seeAll]> ++ (model, see-all) !->
      <- model.room.$loaded
      see-all model.room, model.auth.uid |>
      each (-> model.room.$save elem-index it, model.room)

  )

  s (do
    name: 'chat-us'
    url: '/chat/us'
    template-url: 'app/providers/chat/chat.html'
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
        {room: a, shout: b, auth: c.$get-auth!, us: true}
  )

.filter 'humanize' -> ->
  t = (parse-int it)
  if t then moment t .from-now! else ''
