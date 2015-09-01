angular.module "jonny.admin"
.controller \RootController <[$scope Auth AllUnseenMessagesCount ChatRoot UnseenMessages]> ++ ($scope, Auth, AllUnseenMessagesCount, ChatRoot, UnseenMessages) !->

    auth-data <- Auth.$on-auth
    $scope.auth = auth-data

    if auth-data
    then
      unseen <- AllUnseenMessagesCount!then
      $scope.unseen = unseen

      ChatRoot.$watch !->
        unseen <- AllUnseenMessagesCount!then
        $scope.unseen = unseen



.run <[$window $rootScope]> ++ ($win, $root) !-> $root.go-back = -> $win.history.back();
.run <[$rootScope]> ++ ($root) !->
  e, new-State <- $root.$on '$stateChangeSuccess'
  $root.now-state = new-State.name
