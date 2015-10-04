angular.module "app.controllers"
.controller "ModelOptionsNext"  <[$scope $timeout model options period $state]> ++ ($scope, $timeout, model, options, period, $state) !->

  $scope.options = options
  $scope.model = model
  $scope.failed = false
  $scope.pending = false

  reset = !->
    $scope.failed = false
    $scope.pending = false
  $scope.reset = reset

  start = !-> $scope.pending = true

  apply-reset = !-> $scope.$apply !-> reset!

  $scope.attempt = (promise) !->
    reset! |> start
    promise.then $scope.next,
    ( (e) !->
      $scope.failed = true
      $scope.pending = false
      $scope.last-error = e
      set-timeout apply-reset, period)

  $scope.instatempt = (promise) !-> $state.go $state.current.data.next

  $scope.next = !->
    reset!
    $state.go get-next model

  get-next = ->
    switch
    | _.is-function $state.current.data.next => $state.current.data.next it
    | _ => $state.current.data.next

  $scope.do-next = !->
      reset! |> start
      $state.go get-next model

  if $state.current.data.inject
  then model.next = $scope.next


.controller 'AsyncModelPromiseNext' <[$scope $timeout model $state]> ++ ($scope, $timeout, model, $state) !->
  $scope.loading = true
  $scope.failed = false

  model!then !-> $scope.model = it
