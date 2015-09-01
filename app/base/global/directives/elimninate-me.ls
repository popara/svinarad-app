angular.module "app.base"
.directive 'elinimateMe' -> do
  restrict: 'A'
  link: (scope, elem) !-> elem.remove!
