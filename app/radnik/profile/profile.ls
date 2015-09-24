angular.module 'svinarad.radnik'
.factory 'MyProfile' <[AuthUID fo]> ++ (uid, fo) -> fo "users/#{uid!}"
.factory 'MiniProfile' <[MyProfile]> ++ (p) -> -> {p.name, p.$id, p.rating, p.avatar}
.config <[stateHelperProvider authenticatedOnly]> ++ (state-helper-provider, authenticatedOnly) !->
  s = state-helper-provider.state
  s do
    name: 'profile'
    url: '/profil'
    controller: 'ModelOptionsNext'
    template-url: 'app/radnik/profile/profile.html'
    restrict: authenticatedOnly
    resolve:
      model: \MyProfile
      options: -> do
        save: (profile) ->
          profile.name = "#{profile.first_name} #{profile.last_name}"
          profile.rating = 75
          profile.avatar = do
            plain: false
            url: \https://fillmurray.com/400/400
          profile.$save!
      period: -> 100ms
    data: {next: 'profile'}
