/**
 * User: popara
 * Date: 4/11/15
 * Time: 11:50 AM
 */

angular.module "jonny.providers"
.factory 'Authentication' <[Auth AuthUID visor fo User]> ++ (Auth, uid, visor, fo, User) ->
  auth =
    create-user: (profile) -> let creds = {profile.email, profile.password}
      user <- Auth.$create-user creds .then
      auth <- auth.login creds .then
      name = "#{profile.first_name} #{profile.last_name}"
      u <- User uid! .$loaded
      _.merge u, {profile.email, profile.first_name, profile.last_name, name, earned: 0}
      u.$save!


    login: (creds) ->
      p = Auth.$auth-with-password creds
      (do

        authed-user <-! p.then
        visor.set-authenticated authed-user
      )
      p
    login-with-creds: -> auth.login  {auth.email, auth.password}
    forgot: (email) ->  Auth.$reset-password {email}
    logout: Auth.$unauth
    reset-method: (email, old-password) -> (new-password) ->
      <- Auth.$change-password {email, old-password, new-password} .then
      auth.login {email, password: new-password}

  auth

.config <[visorProvider $stateProvider]> ++ (visorProvider, $stateProvider) !->
  visorProvider.home-route = '/'
  visorProvider.authenticate = <[Auth]> ++ (Auth) -> Auth.$require-auth!then -> it
