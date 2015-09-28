angular.module 'svinarad.poslodavac'
.factory "Authentication" <[Auth]> ++ (Auth) ->
  auth =
    login: (email, password) -> let creds = {email, password}
      Auth.$auth-with-password creds
