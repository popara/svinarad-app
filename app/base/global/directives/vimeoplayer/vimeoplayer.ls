angular.module "app.base"
.directive "vimeoPlayer" <[$rootScope $document $compile]> ++ ($rootScope, $document, $compile) -> (do
  restrict: 'E'
  template-url: 'app/base/global/directives/vimeoplayer/vimeoplayer.html'
  scope:
    video: '='
  link: (scope, elem) !->
    template = (video_id) -> "<iframe src=\"//player.vimeo.com/video/#{video_id}\"></iframe>"
    scope.$watch \video !->
      ($compile template scope.video) scope
      |> elem.empty!append

)
