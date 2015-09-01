/**
 * User: popara
 * Date: 5/17/15
 * Time: 1:09 AM
 */
{sum, map, keys} = require 'prelude-ls'
angular.module "jonny.client"
.directive 'gameProgressBar' <[GameQuestions Levels]> ++ (gq, ls) ->
  do
    restrict: 'E'
    template-url: 'app/clients/game/level/progress-bar/progress-bar.html'
    scope:
      level: \=
    link: (scope) !->
      scope.$watch \level (nv) !->
        | nv => let v = parse-int nv
          scope.current-level = v+1
          if scope.total-levels
          then scope.percentage = (v/scope.total-levels)*100

      qs <- gq.then
      steps = map (-> keys it .length), (map (.questions), ls)
      scope.total-levels = sum steps
