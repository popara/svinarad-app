/**
 * User: popara
 * Date: 4/13/15
 * Time: 4:59 PM
 */
{head, last, values, keys, take, elem-index, map} = require 'prelude-ls'

angular.module "jonny.client"
.directive 'gameLevel' -> (do
  restrict: 'E'
  template-url: 'app/clients/game/level/level.html'
  scope:
    level: '='
    levels: '='
    answers: '='
    model: '='
)
