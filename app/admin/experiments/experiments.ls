{sort-by} = require \prelude-ls

angular.module "jonny.admin"
.config <[stateHelperProvider]> ++ (shp) !->
  s = shp.state

  s (do
    name: 'experiments'
    url: '/experiments'
    template-url: 'app/admin/experiments/experiments.html'
    controller: \Model
    resolve:
      model: \HeadlineExperiments
  )

.factory "HeadlineExperiments" <[fa]> ++ (fa) ->
  (data) <- fa \experiments/headline .$loaded
  success = -> it.attempts / it.hits
  sort-by success, data
