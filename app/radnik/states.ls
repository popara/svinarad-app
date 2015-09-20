angular.module "svinarad.radnik"
.config <[stateHelperProvider $urlRouterProvider authenticatedOnly]> ++ (state-helper-provider, $url-router-provider, authenticatedOnly) !->
  s = state-helper-provider.state

  s do
    name: 'intro'
    url: '/dom'
    template-url: 'app/radnik/intro/intro.html'
    controller: 'Model'
    resolve:
      model: 'Intro'

  s do
    name: 'details'
    url: '/posao/{id}'
    controller: 'Model'
    template-url: 'app/radnik/job/details.html'
    resolve:
      model: <[$stateParams JobById]> ++ (sp, jbid) ->
        # jbid sp.id
        {"$id":"006f422d-bc6c-5816-b6db-c06bc5c37e98","$priority":null,"applicants":{"11111111111111111111111111111111":{"avatar":{"plain":false,"url":"http://www.fillmurray.com/60/60"},"id":"11111111111111111111111111111111","name":"Marc Pearson","rating":60,"when":"30/7/2089 8:15"},"33333333333333333333333333333333":{"avatar":{"plain":false,"url":"http://www.fillmurray.com/60/60"},"id":"33333333333333333333333333333333","name":"Wayne Kelly","rating":90,"when":"24/6/2065 21:29"},"44444444444444444444444444444444":{"avatar":{"plain":false,"url":"http://www.fillmurray.com/60/60"},"id":"44444444444444444444444444444444","name":"Sean Neal","rating":69,"when":"16/4/2053 19:30"}},"credits":1912,"description":"Ozuwu cah nejjiw veh wolsiupi diules pe zov lej zo be evucun biprem pobe lo. Kegug od ogho ugetac lawusium galzoddi ra punu zi bonom ohibumduk jamlofi riczoon mokawo.","employer":{"avatar":{"plain":false,"url":"http://www.fillmurray.com/180/180"},"id":"gggggggggggggggggggggggggggggggg","name":"Joe Strickland","rating":85},"final_instructions":"Jemip ek dekho londo pidheflaj fov ovegik jovav ku nihwagwiz ozlum cifje hiek ovva tetgiel issunmu. Rohuana vud fa demso divlun be oso vigen eca akono gopku danafrag je.","id":"006f422d-bc6c-5816-b6db-c06bc5c37e98","location":{"geo":{"lat":-83.46301,"lng":159.80891},"text":"298 Suun Mill"},"percentage":20,"status":"open","success_condition":"Si po popejlu kapkucse hu wu helebwif ka teetsiv ehi ar ditoc. Cicijul fictin firnina upukin falumo ih kagrudhun jikcif vun vaow tojir se.","timers":{"closed":"8/3/2109 9:14","published":"9/4/2035 15:15"},"title":"Fuasko fudanri vu ef avujir sihi abjihpob duzlindu wepno bak juim umcibgu elado awsi.","total_working_hours":"1","workingPeriod":"11-22"}

  s do
    name: 'login'
    url: '/login'
    template-url: 'app/radnik/auth/login.html'
    controller: 'ModelOptionsNext'
    resolve:
      model: 'Authentication'
      options: -> {}
      period: -> 100ms
    data:
      next: 'intro'

  $url-router-provider.otherwise '/dom'
