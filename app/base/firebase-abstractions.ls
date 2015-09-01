{map, id, sort-with, concat-map, obj-to-pairs} = require 'prelude-ls'
angular.module "app.base"
.factory 'mapToValues' -> ((firebase-object) ->
  set-id = (pair) ->
    pair.1['$id'] = pair.0
    pair.1

  map set-id, obj-to-pairs firebase-object
)
.value "FIREBASE_URL" "https://#{CONFIG.FireBaseNode}.firebaseio.com"
.factory "Firefire" <[FIREBASE_URL]> ++ (BASE_URL) -> ((body) -> new Firebase [BASE_URL, body].join '/')
.factory "fireArray" <[$firebaseArray FIREBASE_URL]> ++ ($firebaseArray, FIREBASE_URL) ->
  (body, extension = {}) -> let fa = $firebaseArray.$extend extension
    # console.log \fa body 
    new fa new Firebase [FIREBASE_URL, body].join '/'

.factory "fireObject" <[$firebaseObject FIREBASE_URL]> ++ ($firebaseObject, FIREBASE_URL) ->
  (body, extension = {}) ->
    # console.log \fo body
    let fo = $firebaseObject.$extend extension
      new fo new Firebase [FIREBASE_URL, body].join '/'

.factory 'fa' <[fireArray]> ++ id
.factory 'fo' <[fireObject]> ++ id

.filter 'orderByMoment' -> ->
  o = (a, b) -> let ma = (moment a.moment), mb = (moment b.moment)
    switch
    | ma.is-before mb  => 1
    | mb.is-before ma  => -1
    | otherwise        => 0
  sort-with o, it
