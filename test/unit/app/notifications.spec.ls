describe "Notifications" (,) !->
  notifs = null
  $httpB = null
  before-each module "jonny.client"
  before-each inject (_Notifications_, _$http-backend_) ->
    notifs := _Notifications_
    $httpB := _$http-backend_

  api-url = -> "http://localhost:8000/api/#{it}"

  client =
    $id: "test:1"
    name: "Pera Peric"
    first_name: "Pera"
    email: "test@pera.rs"


  it "Signup Notification" !->
    $httpB.when \POST (api-url 'notifications/user_registered')
      .respond 'ok'
    $httpB.expectPOST api-url 'notifications/user_registered'
    notifs.user-registered client
    $httpB.flush!


  
