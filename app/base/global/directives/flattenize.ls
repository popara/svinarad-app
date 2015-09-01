{dasherize, words, map, reject, join} = require 'prelude-ls'
angular.module "app.base"
.filter 'flattenize' <[$filter]> ++ (f) -> let lowercase = f 'lowercase'
  ->
    (join '' <| reject (== '&') <| map lowercase <| words it)
