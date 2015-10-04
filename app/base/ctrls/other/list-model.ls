angular.module "app.controllers"
.controller 'ListModel' <[$scope list]> ++ ($scope, list) !->
	$scope.list = list
.controller 'ItemModel' <[$scope item]> ++ ($scope, item) !->
	$scope.item = item
