{last} = require \prelude-ls

describe "controllers" !->
  $ctrl = null
  $root = null
  $state = null

  beforeEach module "jonny.client"
  beforeEach inject (_$controller_, _$root-scope_, _$state_) !->
    $ctrl := _$controller_
    $root := _$root-scope_
    $state := _$state_

  fbmock = -> do
    $loaded: -> do
      then: !->


  describe "Order" (,) ->
    it "On charge should redirect" !->
      $scope = $root.$new!
      oe = do
        get: -> true 

      o-state = $state.get 'order'
      cf = last o-state.controller

      cf $scope, {}, $state, fbmock, fbmock, {}, oe


  describe "ModelOptionsNext" (,) !->
    ctrl = null
    $scope = null
    $timeout = null
    model =
      foo: 5
    options = []
    period = 5
    $q = null

    before-each inject (_$timeout_, _$q_) !->
      $timeout := _$timeout_
      $q := _$q_

    before-each !->
      $scope := $root.$new!

      $state.current.data =
          next: 'Forever'

      ctrl := $ctrl "ModelOptionsNext" do
        $scope: $scope
        model: model
        options: options
        period: period
        $state: $state

    it "Should have next" (done) !->
      $scope.next.should.be.function

      DEF = $q.defer!
      $state.go = ->
        it.should.be.equal 'Forever'
        done!

      $scope.pending.should.be.false
      $scope.attempt DEF.promise
      $scope.pending.should.be.true

      DEF.resolve "OK"
      $timeout.flush!
      $scope.pending.should.be.false

    it "Should not pass on break" !->
      DEF = $q.defer!
      $scope.attempt DEF.promise
      $state.go = ->
        expect false .to.be.ok

      DEF.reject "notOK"
      $timeout.flush!

    it "Should not pass on break" !->
      DEF = $q.defer!
      p2 = DEF.promise.then -> it

      $scope.attempt p2
      $state.go = -> expect true .to.not.be.ok

      DEF.reject "notOK"
      $timeout.flush!
