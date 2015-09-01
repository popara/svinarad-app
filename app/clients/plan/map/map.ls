{map, filter, id, flatten, split-at, obj-to-pairs, keys, reject, each} = require \prelude-ls
angular.module "jonny.client"
.directive "planMap" -> (do
  restrict: 'E'
  template-url: 'app/clients/plan/map/map.html'
  scope: {}
  controller: <[$scope TreasureMap Organizers $window]> ++ (scope, model, options, $window) !->
    m <- model.then
    scope.model = m
    ops <- options.then
    scope.options = ops
    scope.w = $window

  link: (scope, elem) !->
    scope.$on 'TOGGLED' !->
      angular.element scope.w .trigger-handler 'resize'

)

.directive 'triggerResize' <[uiGmapIsReady $interval]> ++ (u, $interval) -> (do
    restrict: 'A'
    link: (scope, elem, attrs) !->
      instances <-! u.promise!then
      time = parse-int attrs.trigger-resize
      map = instances.0.map

      f = !-> google.maps.event.trigger map, 'resize'
      $interval f, 500

)
.factory 'TreasureMap' <[Plan uiGmapIsReady idzer CategoriesObject uiGmapGoogleMapApi $timeout]> ++ (p, uiGmapIsReady, idzer, CategoriesObject, uiGmapGoogleMapApi, $timeout) ->
  var gmap
  decorate = map id

  initial =
    center:
      latitude: 38.964214
      longitude: 1.15
    zoom: 10

  lltol = -> do
    lat: it.latitude
    lng: it.longitude

  ll = ->
    new google.maps.LatLng it

  show-venue =  !->
    switch
    | it =>
      tmap.highlighted = it
      tmap.highlighted-items = existing
    | _ => tmap.highlighted = it


  set-marker = (map, e) --> do
    marker: new google.maps.Marker do
      position: lltol e.venue.location
      title: e.venue.name
      map: map
      animation: google.maps.Animation.DROP
      icon: e.icon
    id: e.$id
    entry: e

  marker-click = (marker) ->
    show-venue marker.entry

  attach-events = (marker) ->
    google.maps.event.add-listener marker.marker, 'click', -> marker-click marker
    marker

  existing = []
  set-categories = (categories) ->
    set-on-gmap = set-marker gmap
    remove-from-map = -> it.set-map null

    fcs = flatten categories
    fcs-ids = map (.id), fcs
    existing-ids = map (.id), existing

    pre-existing = existing
      |> filter (-> it.id in fcs-ids)

    # removing from map those who are not needed
    existing
    |> filter (-> it.id not in fcs-ids)
    |> map (.marker)
    |> map remove-from-map

    # not repainting those that are already painted
    to-paint = fcs
      |> filter (-> it.id not in existing-ids)
      |> map set-on-gmap
      |> map attach-events

    existing := to-paint ++ pre-existing


  reset = ->
    console.log gmap.get-center!
    gmap.set-center lltol initial.center
    gmap.set-zoom initial.zoom
    tmap.set-categories nice-categories!

  tmap = (do
    plan: p
    zoom: _.clone initial.zoom
    center: _.clone initial.center
    highlighted: null
    null-highlight: !->
      tmap.set-category null
      tmap.highlighted = null
    map-options:
      disable-default-UI: yes
      styles:
        * feature-type: "water"
          element-type: "geometry"
          stylers:
            * lightness: 24
            * visibility: "on"
            * color: '#35a9dc'
        * feature-type: "landscape.natural"
          stylers:
            * color: '#ffffff'

    categories: [[]]
    selected-category: null
    set-category: !->
      tmap.selected-category = it
      tmap.set-categories nice-categories!

    category-name: -> CategoriesObject[it]?name
    is-category-selected: -> tmap.selected-category == it
    selected-category-name: -> let sc = tmap.selected-category
      CategoriesObject[sc]?name
    set-categories: set-categories
    clear-all: -> existing := []
    update: ->
      gmaps <-! uiGmapIsReady.promise!.then
      gmap := gmaps.0.map
      tmap.set-categories nice-categories!
      tmap.reset!
    reset: ->
      $timeout reset, 300
  )



  same-icon = (type) -> do
    url: "/img/markers/#{type}.png"
    scaledSize: new google.maps.Size 39 44


  cats = -> it.categories
  decorate-with-type = (type) -> map ((m) ->
    m.type = type
    m.icon = same-icon type
    m
  )

  filter-categories = filter (cat) -> let sc = tmap.selected-category
    not sc or cat.0 == sc


  reject-no-locations = map (cat) ->
    reject (-> not it.venue.location), cat

  nice-categories = ->
    obj-to-pairs cats p
    |> filter-categories
    |> map (pair) ->
      decorate-with-type pair.0
      <| idzer <| pair.1
    |> reject-no-locations

  (do
    gmaps <-! uiGmapIsReady.promise!.then
    gmap := gmaps.0.map
    console.log \xx
    tmap.set-categories nice-categories!
  )

  <- uiGmapGoogleMapApi.then
  <- p.$loaded
  tmap.existingCategories = keys p.categories

  p.$watch !->
    tmap.set-categories nice-categories!
    tmap.existingCategories = keys p.categories

  tmap
