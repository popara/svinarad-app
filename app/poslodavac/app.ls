{head, tail} = require \prelude-ls

angular.module 'svinarad.poslodavac' <[
  app.base
  poslodavac.templates
  ngAnimate
]>

.run <[$rootScope JobStatus]> ++ (root, js) !->
  isst = (a, b) -->
    b and b.status is a
  capt = -> ((head it).to-upper-case!) + (tail it)
  add-is = (obj) ->
    _.map-keys obj, (value, key) -> "is#{ capt key }"

  _.merge root, add-is R.map-obj isst, js
