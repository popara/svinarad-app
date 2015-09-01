angular.module "jonny.client"
.directive 'smallVenue' ->
  do
    restrict: 'E'
    template-url: 'app/clients/venue/small-venue/small-venue.html'
    scope:
      venue: '='
      entry: '='
      id: '='
