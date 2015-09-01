{flip} = require \prelude-ls
angular.module "jonny.providers"
.factory "Notifications" <[HerokuBackendURL Restangular]> ++ (HerokuBackendURL, R) ->
  r = R.all 'notifications'
  p = flip r.doPOST
  (do
    user-registered: (client, ref) -> p "user_registered" do
      client_name: client.name
      client_first_name: client.first_name
      client_email: client.email
      ref: ref

    user-charged: (client, expert, time) -> p "user_charged" do
      client_name: client.name
      client_first_name: client.first_name
      client_email: client.email
      client_id: client.$id
      phoneno: expert.phone
      expert_name: expert.first_name
      expert_email: expert.email
      time: time

    plan-ready: (client, expert) -> p "plan_ready" do
      client_email: client.email
      client_name: client.name
      client_first_name: client.first_name
      expert_name: expert.first_name
      expert_email: expert.email

    wolf-chat: (user, text) -> p "wolf_chat"  do
      user_name: user.name
      user_id: user.$id
      snipp: text

    jonny-chat: (client, expert, text) -> p "jonny_chat" do
      client_id: client.$id
      client_name: client.name
      client_first_name: client.first_name
      client_email: client.email
      expert_name: expert.first_name
      snipp: text

    user-chat: (client, expert, text) -> p "user_chat" do
      client_id: client.$id
      client_name: client.name
      client_first_name: client.first_name
      expert_name: expert.first_name
      expert_phone: expert.phone
      snipp: text

  )
