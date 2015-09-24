/**
 * User: popara
 * Date: 4/15/15
 * Time: 3:01 PM
 */

{id} = require 'prelude-ls'

angular.module "app.controllers"
.controller 'Model' <[$scope model]> ++ ($scope, model) !->
  $scope.pending = false
  $scope.model = model

  $scope.failed = false

  reset = !->
    $scope.pending = false
    $scope.failed = false

  start = !-> $scope.pending = true

  apply-reset = !-> $scope.$apply !-> reset!

  $scope.reset = (scope-var, call) !->
    $scope.pending = true
    <-! call.then
    $scope[scope-var] = null
    $scope.pending = false

  $scope.load = (promise) !->
    reset! |> start
    promise.then reset, error

  error = (e) !->
    $scope.failed = true
    $scope.pending = false
    $scope.last-error = e
    set-timeout apply-reset, 100
    
.controller 'ModelOptions' <[$scope model options]> ++ ($scope, model, options) !->
  $scope.pending = false
  $scope.model = model
  $scope.options = options

  $scope.reset = (scope-var, call) !->
    $scope.pending = true
    <-! call.then
    $scope[scope-var] = null
    $scope.pending = false
