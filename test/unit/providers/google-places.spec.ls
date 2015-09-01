describe "Google Places Integration" (,) !->
  var converter, places, place-details
  var $timeout

  before-each module "jonny.providers"
  before-each inject (_google-place-to-venue_, _Places_, _PlaceDetails_, _$timeout_) !->
    converter := _google-place-to-venue_
    places := _Places_
    place-details := _PlaceDetails_
    $timeout := _$timeout_


  describe "Converter" (,) !->
    it "given Google place output Venue" !->
      gp = do
        place_id: "xxxx"
        name: "Place Name"
        formatted_address: "Address"
        geometry:
          location:
            lat: 45
            lng: 45


  describe "Places" (,) !->
    it "Should be a promise that resolves to a function" ->
      places.should.be.fulfilled


  describe "PlaceDetails" (,) !->
    it "Should be a promise that resolves to a function" ->
      place-details.should.be.fulfilled
