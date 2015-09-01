{reject, sum, map, find, filter} = require \prelude-ls
angular.module "jonny.providers"
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
.factory 'AllClientsRooms' <[ClientRoom UsersToFullfill $q DecorateRoom]> ++ (room, usP, $q, decorate-room) ->
  users <- usP.then

  $q.all map ((user) ->
    room <- room user.$id, user.first_name .$loaded
    r =  decorate-room room, user.$id, users
    r
  ), users

.factory 'UnseenMessages' <[AllClientsRooms unseenByUser AuthUID]> ++ (all-rooms, unseen, me) -> ((user) ->
  rooms <- all-rooms.then
  sum map (-> (unseen it, me!).length), map (.chat-room), rooms
)
.factory 'Home' <[UsersToFullfill Auth AuthUID User AllClientsRooms UnseenMessages unseenByUser]> ++ (user-prom, auth, uid, user, all-rooms, UnseenMessages, unseenByUser)->
  users <- user-prom.then
  u <- user uid! .$loaded!then
  rms <- all-rooms.then
  unseen <- UnseenMessages uid! .then

  unfullfilled = reject (.fullfilled), users
  fullfilled = filter (.fullfilled), users
  (do
    users: unfullfilled
    fullfilled: fullfilled
    auth: auth
    user: u
    rooms: rms
    unseen: unseen
    help-unseen: (room) -> let unseen = unseenByUser room, uid!
      unseen.length
  )
