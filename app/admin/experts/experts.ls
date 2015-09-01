{keys, filter} = require \prelude-ls

angular.module "jonny.admin"
.config <[stateHelperProvider]> ++ ((shp) !->
  s = shp.state

  s (do
    name: 'experts'
    url: '/experts'
    template-url: 'app/admin/experts/experts.html'
    controller: \ModelOptions
    resolve:
      model: \LiveExperts
      options: \VimeoThumbs

  )
)
.factory "LiveExperts" <[Experts UsersArr]> ++ ((Experts, UsersArr) ->
  <- Experts.$loaded
  <- UsersArr.$loaded
  exp-ids = keys Experts
  filter (.$id in exp-ids), UsersArr
)
.factory "VimeoThumbs" <[$http]> ++ (($http) ->
  url = (video) -> "http://vimeo.com/api/v2/video/#{video}.json"
  small-thumb = -> it.data.0.thumbnail_small

  (user) -> $http.get (url user.vimeo_id), {+cache} .then small-thumb
)
.directive "asyncSrc" -> (do
  restrict: 'A'
  scope:
    src: '=asyncSrc'
    item: '='
  link: (scope, elem) !->
    scope.src scope.item .then !-> elem.attr 'src' it
)
.factory "VerificationOptions" -> do
  email: "Email"
  gplus: "Google Plus"
  id: "ID"
  phone: "Phone"
