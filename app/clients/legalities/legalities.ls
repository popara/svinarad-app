angular.module "jonny.client"
.config <[stateHelperProvider]> ++ (shp) !->
  s = shp.state

  s (do
    name: 'terms'
    url: '/terms'
    template-url: 'app/clients/legalities/terms.html'
  )

  s (do
    name: 'contact'
    url: '/help/contact'
    template-url: 'app/clients/legalities/contact.html'

  )
