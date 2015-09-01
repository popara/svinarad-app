{split, head} = require \prelude-ls
angular.module "app.base"
.value "isAnon" (id) -> "anonymous" == head split \: id
.value "isSimple" (id) -> "simplelogin" == head split \: id
.factory 'Users' <[fireArray]> ++ (fireArray) -> fireArray 'users'
.factory 'Auth' <[$firebaseAuth FIREBASE_URL]> ++ ($firebaseAuth, FIREBASE_URL) ->
 $firebaseAuth new Firebase FIREBASE_URL
.factory 'AuthUID' <[Auth]> ++ (auth) -> -> auth.$get-auth!?uid
.factory 'UserProfile' <[User AuthUID]> ++ (u, uid) -> -> u uid!
.factory 'Profile' <[AuthUID fo]> ++ (a, fo) -> (do
  get: -> fo "users/#{a!}"
  id: -> fo "users/#{it}"
  save: -> u.$save a!
)
.factory "Experts" <[fo]> ++ (fo) -> fo "experts"
.factory "UsersArr" <[fa]> ++ (fa) -> fa "users"
.factory "UsersObj" <[fo]> ++ (fo) -> fo "users"
.factory 'Plan' <[fo]> ++ (fo) -> (user-id) -> fo "plan/#{user-id}"
