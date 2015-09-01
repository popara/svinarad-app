{find-index, head, last} = require \prelude-ls

angular.module "jonny.client"
.directive "venuehighlighter" -> (do
  restrict: 'E'
  template-url: 'app/clients/plan/map/venuehighlighter/venuehighlighter.html'
  scope:
    items: '='
    highlighted: '='

  link: (scope) !->
    prev = (arr) -> let i = get-index!
      switch
      | i <= 0 => get-last arr
      | _ => arr[i-1]

    next = (arr) -> let i = get-index!
      switch
      | i+1 < arr.length => arr[i+1]
      | _ => get-first arr

    get-last = (arr) -> last arr
    get-first = (arr) -> head arr

    get-index = -> let h = scope.highlighted, items = scope.items
      find-index (== h), items
    scope.prev = -> scope.highlighted = prev scope.items
    scope.next = -> scope.highlighted = next scope.items


)
