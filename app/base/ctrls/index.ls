angular.module "app.controllers" <[ng]>
.controller "AsyncModel" <[$scope model]> ++ ($scope, model) ->
  a-model <- model.then
  $scope.model = a-model
