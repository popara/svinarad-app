angular.module "app.base"
.directive "countrySelect" <[Countries]> ++ (countries) -> (do
  restrict: 'A'
  link: (scope, elem) !-> scope.countries = countries
)
