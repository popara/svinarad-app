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

  $scope.reset = (scope-var, call) !->
    $scope.pending = true
    <-! call.then
    $scope[scope-var] = null
    $scope.pending = false

.controller 'ModelOptions' <[$scope model options]> ++ ($scope, model, options) !->
  $scope.pending = false
  $scope.model = model
  $scope.options = options

  $scope.reset = (scope-var, call) !->
    $scope.pending = true
    <-! call.then
    $scope[scope-var] = null
    $scope.pending = false
