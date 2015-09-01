angular.module "jonny.admin"
.directive "stars" -> (do
  restrict: 'E'
  template-url: 'app/admin/global/rating/rating.html'
  scope:
    stars: '='
  link: (scope) !->
    scope.range = -> _.range 1 it+1

)

.directive "svgStars" -> (do
  restrict: 'E'
  template-url: 'app/admin/global/rating/rating-icons.html'
  scope:
    stars: '='
  link: (scope) !->
    scope.range = -> _.range 1 it+1
    scope.star-as = (star) -> let diff = scope.stars - star
      switch
      | diff >= 0 => 'star'
      | diff < 0.4 and diff > -1 => 'star_half'
      | _ => 'star_outline'


)
