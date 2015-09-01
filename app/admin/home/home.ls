{sum, map, find, filter, reject, split, head, reverse, keys, group-by, sort-by} = require \prelude-ls
angular.module "jonny.admin"

.factory "UnfocusedChatRoom" <[fa]> ++ (fa) -> (client)-> fa "chat/#{client}/agent"
.factory 'UsersToFullfill' <[Auth Users $firebaseArray ClientExt]> ++ (Auth, Users, $firebaseArray, C) ->
  uid = Auth.$get-auth!uid
  $firebaseArray (Users.$ref!order-by-child 'expert' .equal-to uid)
    .$loaded (a) -> map (-> _.merge it, C), a
.factory "DecorateRoom" -> ((room, user, users) ->
  (do
    chat-room: room
    client: find (.$id == user), users
  )
)
.factory 'AllClientsRooms' <[ClientRoom UsersArr $q DecorateRoom isAnon]> ++ (room, usP, $q, decorate-room, is-anon) ->
  users <- usP.$loaded
  us = users
    |> reject (-> is-anon it.$id)
    |> reject (-> not it.name)

  $q.all map ((user)->
    room <- room user.$id, user.first_name .$loaded
    decorate-room room, user.$id, users
  ), us

.factory 'UnseenMessages' <[AllClientsRooms unseenByUser AuthUID]> ++ (all-rooms, unseen, me) -> ((user) ->
  rooms <- all-rooms.then
  sum map (-> (unseen it, me!).length), map (.chat-room), rooms
)

.factory 'Home' <[UsersArr UsersObj Experts UnfocusedChatRoom Plan isAnon isSimple $q]> ++ (users, user-obj, experts, chat-room, plan, is-anon, is-simple, $q) ->
  <- users.$loaded
  <- user-obj.$loaded
  <- experts.$loaded

  ex-keys = keys experts |> filter is-simple
  is-expert = (.$id in ex-keys)
  payed = -> !!it.payed
  unnamed = -> not it.name
  fullfilled = ->
    if it.user.fullfiled
    then "done"
    else "notdone"

  user-to-case = (u) -> do
    user: u
    expert: user-obj[u.expert]
    chat: chat-room u.$id
    plan:  plan u.$id

  timeleft = -> parse-int it.plan.delivery

  f = users
    |> reject (u) -> is-anon u.$id
    |> filter payed
    |> reject is-expert
    |> reject unnamed
    |> reverse
    |> map user-to-case
    |> group-by fullfilled

  <- ($q.all map (.plan.$loaded!), f.notdone ).then
  f.notdone = sort-by timeleft, f.notdone |> reverse

  (do
    cases: f
  )
