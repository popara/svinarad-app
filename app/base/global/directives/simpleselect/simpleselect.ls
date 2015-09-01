angular.module "app.base"
.directive "simpleselect" -> (do
  restrict: 'E'
  template-url: 'app/base/global/directives/simpleselect/simpleselect.html'
  scope:
    change: '&'
    selected: '&'
    options: '='
    label: '&'
    null-title: '@'

  link: (scope) !->
    scope.open = false
    scope.toggle-open = -> scope.open = not scope.open
    scope.title = ""

    close-after = (f) -> ->
      f.apply f, arguments
      scope.open = false

    set-title = -> scope.title = it

    scope.click = close-after (option) !->
      scope.change {option}
      set-title scope.get-label option
    scope.is-selected = (option) -> scope.selected {option}
    scope.get-label = (option) -> scope.label {option}

    scope.null-click = -> scope.click null



)
