angular.module "jonny.providers"
.directive "jdeck" <[Categories fa]> ++ (Categories, fa) -> (do
  restrict: 'E'
  scope:
    deck: \=
    change: \&
    delete: \&
  template-url: 'app/providers/presets/jdeck/jdeck.html'
  link: (scope, elem) !->
    scope.$watch \deck scope.change, true
    scope.cats = Categories
    scope.cards  = fa (scope.deck.$ref!child \cards .path.n.join \/)
    scope.delete-it = !->
      if confirm "Are you sure you want to delete this deck? There is no Recycle Bin here!"
      then scope.delete! 
)
.directive "miniDeck" -> (do
  restrict: 'E'
  template-url: 'app/providers/presets/jdeck/mini-deck.html'
  scope:
    deck: \=
)
