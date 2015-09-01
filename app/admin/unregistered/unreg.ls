{map, filter, reverse} = require \prelude-ls

angular.module "jonny.admin"
.config <[stateHelperProvider]> ++ (shp) !->
  s = shp.state

  s (do
    name: 'unregistered'
    url: '/unreg'
    controller: \Model
    template-url: 'app/admin/unregistered/unreg.html'
    resolve:
      model: <[Users AllAnswers extractFromAnswers]> ++ (users, ans, extractFromAnswers) ->
        <- users.$loaded
        <- ans.$loaded
        anon-ids = map (.anon), users
        ans
        |> filter (-> it.$id not in anon-ids)
        |> map extractFromAnswers
        |> reverse
  )

.factory "AllAnswers" <[fa]> ++ (fa) -> fa \answers
.factory "extractFromAnswers" ->
  get-value = (id, answers) --> answers[id]?value


  about = get-value '-JqBllrTlgnJevhZHDjZ'
  dates = get-value '-JqBllrXAD_fazRnx6HO'

  (answer) ->
    do
      about: about answer
      dates: dates answer
