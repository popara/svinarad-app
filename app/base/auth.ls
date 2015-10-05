{split, head} = require \prelude-ls
angular.module "app.base"
.factory 'Users' <[fireArray]> ++ (fireArray) -> fireArray 'users'

.factory 'Auth' <[$firebaseAuth BaseFireRef]> ++ ($firebaseAuth, BaseFireRef) ->
   $firebaseAuth BaseFireRef

.factory 'AuthUID' <[Auth]> ++ (auth) -> -> auth.$get-auth!?uid

.run <[Auth visor]> ++ (Auth, visor) !->
  Auth.$on-auth visor.set-authenticated

.config <[visorProvider $stateProvider]> ++ (visorProvider, $stateProvider) !->
  visorProvider.authenticate = <[Auth]> ++ (Auth) -> Auth.$require-auth!
