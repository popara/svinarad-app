angular.module "app.controllers"
.controller 'modal' <[$scope $state]> ++ ($scope, $state) !->
  $scope.$emit 'open-modal' true
  $scope.close = !-> 
    $scope.$emit 'open-modal' false
    $state.go '^' 