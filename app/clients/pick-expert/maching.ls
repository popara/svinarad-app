angular.module "jonny.client"
.config <[stateHelperProvider authenticatedOnly]> ++ (shp, authenticatedOnly) !->
  s = shp.state

  s (do
    name: 'matching'
    url: '/matching'
    template-url: 'app/clients/pick-expert/matching.html'
    controller: \showAndGoAway
    restrict: authenticatedOnly
    resolve:
      destination: -> 'pickexpert'
      period: -> 5000
  )

.factory "Job" <[fo AuthUID]> ++ (fo, uid) ->
  j = fo "/jobs/#{uid!}"

  (do
    <- j.$loaded
    if j.status != 'created'
      j.owner = uid!
      j.$save!
  )

  j

.factory "MatchingWithExperts" <[Job Restangular]> ++ (job, R) ->
  <- job.$loaded
  do
    start: -> R.all "/job/start/#{job.$id}" .doPOST!
