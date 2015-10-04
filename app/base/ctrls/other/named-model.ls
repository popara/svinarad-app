
angular.module "app.controllers"
.controller 'NamedModel' <[$scope namedModel]> ++ ($scope, named-model) !->
  $scope[named-model.__name] = named-model


name-it = (name, thing) -->
    thing.__name = name
    thing

name-promise = (name, promise) -->
  promise.then (result) -> name-it name, result



