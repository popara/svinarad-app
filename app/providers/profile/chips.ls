{is-type} = require \prelude-ls

angular.module "jonny.providers"
.directive "chips" -> (do
  restrict: 'E'
  template-url: 'app/providers/profile/chips.html'
  scope:
    model: \=
  link: (scope, elem, attrs) !->
    scope.placeholder = attrs.placeholder
    scope.delete = (c) ->
      scope.model = _.without scope.model, c
    scope.add = (c) ->
      scope.model.push c
      scope.text = ''

    if not is-type "Array" scope.model
    then scope.model = []
)
