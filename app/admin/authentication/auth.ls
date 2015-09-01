/**
 * User: popara
 * Date: 4/11/15
 * Time: 11:50 AM
 */

angular.module "jonny.admin"

.factory 'Profile' <[Users Auth fo]> ++ (u, a, fo) -> (do
  get: -> fo (u.$ref!child a.$get-auth!uid).path
  save: -> u.$save a.$get-auth!uid
)


.factory 'Authentication' <[Auth AuthUID visor fireObject]> ++ (Auth, uid, visor, fireObject) ->
  auth =
    email: ''
    login: (creds) -> let p = Auth.$auth-with-password creds
      (do
        authed-user <-! p.then
        visor.set-authenticated authed-user
      )
      p
    login-with-creds: -> let creds = {email: auth.email, password: auth.password}
      auth.login creds

    forgot: (email) ->  Auth.$reset-password {email}
    logout: Auth.$unauth


  auth

.config <[visorProvider $stateProvider]> ++ (visorProvider, $stateProvider) !->
  visorProvider.home-route = '/'
  visorProvider.authenticate = <[Auth]> ++ (Auth) -> Auth.$require-auth!then -> it
