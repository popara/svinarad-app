angular.module "jonny.providers"
.factory "Places" <[uiGmapGoogleMapApi $q]> ++ (uiGmapGoogleMapApi, $q) ->
  maps <- uiGmapGoogleMapApi.then
  ne = new maps.Lat-lng 39.144877, 1.682599
  sw = new maps.Lat-lng 38.593164, 1.138776
  bounds = new maps.Lat-lng-bounds ne, sw
  service = new maps.places.Autocomplete-service!

  (q) ->
    def = $q.defer!
    service.get-place-predictions {input: q}, (rs) !-> def.resolve rs
    def.promise


.factory "PlaceDetails" <[uiGmapGoogleMapApi $q hiddenMap]>  ++ (uiGmapGoogleMapApi, $q, hiddenMap) ->
  hm <- hiddenMap.then
  maps <- uiGmapGoogleMapApi.then
  service = new maps.places.Places-service hm

  (place-id) ->
    def = $q.defer!
    service.get-details {place-id}, (rs, status) !->
      | status == maps.places.Places-service-status.OK => def.resolve rs
      | _ => def.reject status
    def.promise

.factory "convertDetails" <[PlaceDetails googlePlaceToVenue]> ++ (details, converter) ->
  get-details <- details.then
  (place) -> get-details place.place_id .then -> converter it

.factory "hiddenMap" <[uiGmapIsReady]> ++ (uiGmapIsReady) ->
  instances <- uiGmapIsReady.promise!then
  instances.0.map
