angular.module "jonny.providers"
.directive "wish"  -> (do
  restrict: 'E'
  template-url: 'app/providers/client/wish.html'
  scope:
    question: \=
    answer: \= 
)
