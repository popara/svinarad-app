{map, id, sort-with, concat-map, obj-to-pairs} = require 'prelude-ls'
angular.module "app.base"
.factory 'mapToValues' -> ((firebase-object) ->
  set-id = (pair) ->
    pair.1['$id'] = pair.0
    pair.1

  map set-id, obj-to-pairs firebase-object
)
.value "FIREBASE_URL" "https://#{CONFIG.FireBaseNode}.firebaseio.com"
.factory "Firebase" <[$window]> ++ ($window) -> $window.Firebase
.factory "BaseFireRef" <[FIREBASE_URL Firebase]> ++ (BASE_URL, Firebase) ->
  new Firebase BASE_URL
.factory "Firefire" <[BaseFireRef]> ++ (BaseFireRef) ->
  (body) -> BaseFireRef.child body 

.factory "FF" <[Firefire]> ++ id
.factory "fireArray" <[$firebaseArray FF]> ++ ($firebaseArray, ff) ->
  (body, extension = {}) -> let fa = $firebaseArray.$extend extension
    fa ff body

.factory "fireObject" <[$firebaseObject FF]> ++ ($firebaseObject, ff) ->
  (body, extension = {}) ->
    let fo = $firebaseObject.$extend extension
      fo ff body

.factory 'fa' <[fireArray]> ++ id
.factory 'fo' <[fireObject]> ++ id
.factory '$fa' <[$firebaseArray]> ++ id
.factory '$fo' <[$firebaseObject]> ++ id

.filter 'orderByMoment' -> ->
  o = (a, b) -> let ma = (moment a.moment), mb = (moment b.moment)
    switch
    | ma.is-before mb  => 1
    | mb.is-before ma  => -1
    | otherwise        => 0
  sort-with o, it
