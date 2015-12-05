{keys, values, reverse} = require 'prelude-ls'

angular.module "app.base"
.filter "prelude_reverse" -> reverse
.filter "dashCase" ->
  (a) ->
    if a?
    then a.replace '.' '-'
    else a

.filter "objlen" ->
  objlen = R.keys >> (.length)
  (a) ->
    if a?
    then objlen a
    else 0
.filter "pronun" -> ((object, type) ->
  pronuns =
    direct:
      male: 'he'
      female: 'she'
      other: 'it'


  pronuns[type][object]
)
.filter 'cnt' -> (x) -> (keys x).length
.filter 'cntItems' -> (x) -> x |> values |> keys |> (.length)
.filter 'toMoment' -> -> moment parse-int it
.factory 'timestamp' -> -> + moment.utc!
.factory 'datetime' -> -> + moment.utc!
.factory 'klog' ->
  ->
    console.log it
    it

.filter 'momentize' -> (time, format) -> moment time .format format
.filter 'humanTime' -> ((time, format) -> let t = parse-int time
  if t
  then moment parse-int time .format format
  else ''
)
