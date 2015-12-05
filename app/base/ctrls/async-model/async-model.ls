angular.module 'app.controllers' []
.controller 'AsyncModel' <[$scope model $q]> ++ ($scope, model, $q) !->
  is-obj = -> R.is Object, it
  has-then = -> R.has-in 'then' it
  is-promise = ->
    (is-obj it) and (has-then it)

  loading = model
    |> R.keys
    |> R.map -> [it, is-promise model[it]]
    |> R.fromPairs

  any-loading = (loading) -> let vls = R.values loading
    (not R.is-empty vls) and  (R.any R.identity, vls)

  single-fullfil = (key, r) -->
    $scope.loading[key] = false
    $scope.model[key] = r
    $scope.any-loading = any-loading $scope.loading

  single-error = (key, err) -->
    $scope.loading[key] = false
    $scope.errors[key] = err
    $scope.any-error = true
    $scope.any-loading = any-loading $scope.loading

  promise-pairs = model
    |> R.to-pairs
    |> R.filter ([_, prom])-> is-promise prom
    |> R.map ([k, pro]) ->
      pro-prim = pro.then (single-fullfil k), (single-error k)
      [k, pro-prim]

  non-promises = model
    |> R.to-pairs
    |> R.filter ([_, val]) -> not is-promise val
    |> R.from-pairs

  promises = R.map (.1), promise-pairs

  $scope.any-error = false
  $scope.errors = {}
  $scope.model = R.merge {}, non-promises
  $scope.loading = loading
  $scope.any-loading = any-loading loading
