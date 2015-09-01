angular.module "jonny.admin"
.directive "wish"  -> (do
  restrict: 'E'
  template-url: 'app/admin/client/wish.html'
  scope:
    question: \=
    answer: \= 
)
