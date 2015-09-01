/**
 * User: popara
 * Date: 4/11/15
 * Time: 11:50 AM
 */
{last, map, head, tail, words, unwords, reject, id, reverse} = require 'prelude-ls'
P = require 'prelude-ls'

angular.module "jonny.client"
.constant 'SemiAnonKey' 'semianon'
.factory 'SemiAnonAuth' <[localStorageService SemiAnonKey Auth $q]> ++ (local-storage, key, auth, $q) ->
  defer = $q.defer!
  prev-auth = local-storage.get key

  if prev-auth
  then defer.resolve local-storage.get key
  else
    auth.$auth-anonymously!then (auth) !->
      local-storage.set key, auth
      defer.resolve auth

  (do
    get: -> defer.promise
  )

.factory 'RefHelper' -> {ref: ''}
.factory 'PostSignup' <[fo $firebaseUtils Answers Notifications RefHelper]> ++ (fo, util, Answers, Notif, ref) -> ((user, pre-user) ->
    user.anon = pre-user.uid
    user.$save!then -> Notif.user-registered user, ref.ref
)
.factory "PostLogin" <[visor Experts $window]> ++ (visor, Experts, $window) -> ((authload) ->
  <- Experts.$loaded
  if authload.uid in map (.$id), Experts
  then $window.location.href = '/expert'
  authload
)
.factory "randomSalt" -> (->
    P.Str.chars (moment!format 'x')
    |> reverse
    |> P.take 5
    |> -> it ++ [_.sample [0 to 99]]
    |> P.Str.unchars
)
.factory 'Authentication' <[Auth visor fireObject SemiAnonAuth $firebaseObject PostSignup User PostLogin RefHelper randomSalt]> ++ (Auth, visor, fireObject, semi-anon, FO, post-signup, User, PostLogin, ref, random-salt) ->
  Auth.$onAuth visor.set-authenticated

  make-user = (id, user) ->
    f = fireObject "users/#{id}"
    u <- f.$loaded!then
    _.merge u, user
    u.$save!then -> post-signup-migration u

  notify-user = !-> alert 'There is an issue with Chrome on iOS and Facebook popups. Please consider Registering with Email, or open this page in Safari for iOS to continue with Facebook signup. Many thanks for the understanding!'
  fall-back-to-redirect = (after) ->  (err) ->
    switch err.code
    | \TRANSPORT_UNAVAILABLE =>
      notify-user!
      Auth.$auth-with-o-auth-redirect \facebook {scope: 'email'}
        .then after

    | _ => throw err

  post-signup-migration = (user) ->
    sa <- semi-anon.get!then
    post-signup user, sa

  fb-signup = (auth-data) ->
      make-user auth-data.uid, extract-fb auth-data.facebook
  random-thing = -> _.sample <[pinacolada coconut talamanca chupito mojito]>

  auth =
    email: ''
    create-user: -> auth.save-user auth.email, auth.password
    save-user: (email, password) ~> let name = auth.name
      creds = {email, password}
      user <- Auth.$create-user creds .then
      authload <- auth.login creds .then
      visor.set-authenticated authload
      make-user Auth.$get-auth!uid, _.merge {email}, extract-name name

    login: (creds) -> Auth.$auth-with-password creds .then PostLogin
    login-with-creds: -> auth.login {auth.email, auth.password}
    forgot: (email) ->  Auth.$reset-password {email}
    sign-up-with-facebook: ->
      Auth.$auth-with-o-auth-popup \facebook {scope: 'email'}
        .then fb-signup
        .catch fall-back-to-redirect signup

    signup-with-built-in-pass: (email, name) ->
      auth.name = name
      auth.email = email
      ref.ref = auth.built-in-pass email
      auth.save-user email, ref.ref

    signued-up: (email) -> let a = Auth.$get-auth!
      switch
      | a => a.auth.provider == 'password' and a.password.email == email
      | _ => false


    built-in-pass: (email) -> random-thing! + random-salt!
    login-with-facebook: ->
      login = (auth-data)  ->
        u <- User auth-data.uid .$loaded
        if not u.name
        then fb-signup auth-data
        else auth-data


      Auth.$auth-with-o-auth-popup \facebook {scope: 'email'}
        .then login
        .catch fall-back-to-redirect login


  extract-name = (name) ->  let sampl = words name
    switch
    | sampl.length <= 1 => {name, first_name: name}
    | _ => do
      first_name: (head sampl)
      last_name: (unwords tail sampl)
      name: name

  extract-fb = -> let c = it.cached-user-profile
    {c.name, c.first_name, c.last_name, fb_id: c.id, fb_link: c.link, c.email,
    c.gender, c.locale, age: 'min '+c.age_range.min, pic: {url: c.picture.data.url, thumb:c.picture.data.url}}

  auth

.config <[visorProvider $stateProvider]> ++ (visorProvider, $stateProvider) !->
  visorProvider.authenticate = <[Auth]> ++ (Auth) -> Auth.$require-auth!
  visorProvider.doAfterManualAuthentication = [id]
