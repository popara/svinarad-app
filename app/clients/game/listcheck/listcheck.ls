angular.module "jonny.client"
.directive 'listCheck' ->
  do
    restrict: 'E'
    template-url: 'app/clients/game/listcheck/listcheck.html'
    scope:
      items: '='
      item-checked: '&'
      toggle-item: '&'
      item-label: '&'
    link: (scope) !->
      scope.toggle = (value) ->
        scope.toggle-item {value}
      scope.is-checked = (value) ->
        scope.item-checked {value}
      scope.label = (item) ->
        scope.item-label {item}
