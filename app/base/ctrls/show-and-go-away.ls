angular.module "app.controllers"
.controller "showAndGoAway" <[$state $timeout period destination]> ++ ($state, $timeout, period, destination) !->
		move-to-next = !-> $state.go destination
		$timeout move-to-next, period