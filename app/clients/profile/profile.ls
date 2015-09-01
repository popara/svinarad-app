angular.module "jonny.client"
.config <[stateHelperProvider $urlRouterProvider]> ++ (stateHelperProvider, u) !->
  s = stateHelperProvider.state

  s (do
    name: 'profile'
    url: '/profile'
    template-url: 'app/clients/profile/profile.html'
    controller: 'ModelOptionsNext'
    resolve:
      model: \ProfileCollector
      options: \Genders\
      period: -> 4
    data: {next: 'game-intro'}
    abstract: yes
    children:
      * name: 'intro'
        url: '/intro'
        template-url: 'app/clients/profile/intro.html'
        controller: 'Model'
      * name: 'simpleform'
        url: '/form'
        template-url: 'app/clients/profile/form.html'
  )



.factory 'ProfileCollector' <[fo Profile Auth]> ++ (fo, profile, auth) ->
  prof = profile.get!
  get-auth = (provider) -> provider
  get-prof-data = (it) ->
    {it.name, it.first_name, it.last_name, fb_id: it.id, fb_link: it.link}

  save-it = -> prof.$save!


  (do
    p: prof
    auth: get-auth
    save: save-it
  )


.factory 'Genders' -> [
  [\male 'Male']
  [\female 'Female']
  [\other 'Something special']
]
.factory 'Preference' -> [
  [\straight 'Straight']
  [\gay 'Gay']
  [\complicated 'Complicated']
]
