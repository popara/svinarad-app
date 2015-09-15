{split, head} = require \prelude-ls
angular.module "app.base"
.value "isAnon" (id) -> "anonymous" == head split \: id
.value "isSimple" (id) -> "simplelogin" == head split \: id
.factory 'Users' <[fireArray]> ++ (fireArray) -> fireArray 'users'
.factory 'Auth' <[$firebaseAuth FIREBASE_URL]> ++ ($firebaseAuth, FIREBASE_URL) ->
   $firebaseAuth new Firebase FIREBASE_URL
.factory 'AuthUID' <[Auth]> ++ (auth) -> -> auth.$get-auth!?uid
.run <[Auth visor]> ++ (Auth, visor) !->
  Auth.$on-auth visor.set-authenticated
.config <[visorProvider $stateProvider]> ++ (visorProvider, $stateProvider) !->
  visorProvider.authenticate = <[Auth]> ++ (Auth) -> Auth.$require-auth!
