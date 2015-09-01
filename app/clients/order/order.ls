angular.module "jonny.client"
.config <[stateHelperProvider authenticatedOnly]> ++ (stateHelperProvider, authenticatedOnly) !->
  s = stateHelperProvider.state

  s (do
    name: 'order'
    url: '/order'
    template-url: 'app/clients/order/order.html'
    controller: <[$scope Charger $state UserProfile Plan Notifications OptedExpert]> ++ ($scope, Charger, $state, user, Plan, Notifications, OptedExpert) !-> let user = user!
      (do
        user <- user.$loaded
        switch
        | user.payed => $state.go 'waiting' {fr: Cookies \__ffff }
        | not OptedExpert.get! => $state.go 'pickexpert'
      )

      $scope.opted = OptedExpert.get!
      $scope.pending = false
      $scope.start = !-> $scope.pending = true

      $scope.payment = (status, response) !->
        $scope.pending = true

        if response.error
        then
          $scope.error = response.error
          $scope.pending = false
        else
          Charger
            .charge response.id, user.email, user.name
            .then upon-payment
            .catch !->
              $scope.error = it
              $scope.pending = false


      upon-payment = !->
        m = moment!

        user.payed = m.format 'x'
        user.$save!
        Plan.delivery = m.add 1 'd' .format 'x'
        Plan.$save!

        time = m.format 'HH:mm'

        fr =  Cookies \__ffff
        alert 'Your payment was successful!'
        Notifications.user-charged user, OptedExpert.get!, time
        $state.go 'after-buy' {fr: fr}

  )

  s (do
    name: 'after-buy'
    url: '/order/confirmation'
    template-url: 'app/clients/order/confirm.html'
    controller: 'Model'
    resolve:
      model: <[OptedExpert]> ++ (a) -> a.get! 
  )

.config !-> Stripe?.set-publishable-key CONFIG.STRIPE_KEY

.factory 'Charger' <[$http HerokuBackendURL]> ++ ($http, base, Notif) ->
  url = "#{base}/charge"
  (do
    charge: (token, email, name) -> $http.post url, {token, email, name}
  )
