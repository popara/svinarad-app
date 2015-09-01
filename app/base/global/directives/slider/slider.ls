angular.module "app.base"
.directive 'slider' ->
  do
    restrict: 'E'
    template-url: 'app/base/global/directives/slider/slider.html'
    scope:
      min: '='
      max: '='
      step: '='
      model: '='
      name: '&'
