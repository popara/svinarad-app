{join} = require 'prelude-ls'
angular.module 'app.base'
.factory 'Move' <[$q]> ++ ($q) ->
  (new-path, ref, id) ->
    new-ref = ref.root!child new-path .child id
    do
      resolve, reject <-! $q
      snap <- ref.on 'value'
      val = snap.val!
      ref.remove!
      new-ref.set val
      resolve!
