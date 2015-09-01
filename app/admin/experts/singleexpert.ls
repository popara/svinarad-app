angular.module "jonny.admin"
.config <[stateHelperProvider]> ++ ((shp) !->
  s = shp.state

  s (do
    name: 'expert'
    url: '/expert/:id'
    template-url: 'app/admin/experts/singleexpert.html'
    controller: \ModelOptions
    resolve:
      model: <[$stateParams User]> ++ (sp, user) -> user sp.id
      options: <[VerificationOptions]> ++ (verif) -> do
        verif: verif
        id: true
        email: false 
        verify: !->
          console.log arguments
  )
)
.directive "checkboxes" -> (do
  restrict: 'A'
  link: (scope, elem) !->
    # $ \.ui.radio.checkbox .checkbox!
    $ \.ui.checkbox .checkbox!
)
