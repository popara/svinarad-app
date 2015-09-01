{reverse, reject} = require \prelude-ls

angular.module "jonny.admin"
.config <[stateHelperProvider]> ++ (shp) !->
  s = shp.state

  s (do
    name: 'nonpayed'
    url: '/nonpayed'
    template-url: 'app/admin/nonpayed/nonpayed.html'
    controller: \Model
    resolve:
      model: <[UsersArr]> ++ (users) ->
        <- users.$loaded
        users
        |> reject (.payed)
        |> reverse
  )
