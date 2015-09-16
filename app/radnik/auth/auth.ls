angular.module 'svinarad.radnik'
.factory "Authentication" <[Auth]> ++ (Auth) ->
  auth =
    login: (email, password) -> let creds = {email, password}
      Auth.$auth-with-password creds
