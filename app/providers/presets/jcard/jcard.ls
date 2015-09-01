angular.module "jonny.providers"
.directive "jcard" <[Categories Places convertDetails]> ++ (Categories, Places, convertDetails) -> (do
  restrict: 'E'
  template-url: 'app/providers/presets/jcard/jcard.html'
  scope:
    card: \=
    delete: \&
    change: \&

  link: (scope) !->
    scope.ac = {}
    scope.categories = Categories
    scope.doDelete = !->
      if confirm "Are you sure you want to delete this card?"
      then scope.delete {scope.card}

    scope.$watch \card (_.throttle scope.change, 400), true

    (do
      convert <- convertDetails.then
      scope.set-v = (venue) ->
        | venue => convert venue .then (v) !-> scope.card.entry.venue = v
        | _ => scope.card.entry.venue = null
    )

    (do
      search <- Places.then
      scope.venues = search
    )
)
