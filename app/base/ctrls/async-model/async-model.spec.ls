{all, id} = require 'prelude-ls'
describe 'Async Model Controller' (,) !->
  var async-ctrl, $scope, a-ctrl, $q, deffered, timeout
  before-each module 'app.base'
  before-each inject (_$q_, _$timeout_) !->
    $q := _$q_
    timeout := _$timeout_
    deffered := $q.defer!
    $scope := {}

  before-each inject ($controller) !->
    a-ctrl := (obj) -> $controller 'AsyncModel' obj


  describe 'Loading indicators for non-promises' (,) !->
    before-each !->
      model =
        foo: 5
      async-ctrl := a-ctrl {$scope, model}

    it 'Should set loading object' !->
      expect $scope.loading .to.be.a \object

    it 'Should set loading of non-promises to false' !->
      expect (
        $scope.loading |> R.values |> all id
      ) .to.be.not.ok

    it 'Should have total loading indicator to false' !->
      expect $scope.any-loading .to.be.not.ok



  describe 'Loading indicators for promises' (,) !->
    before-each !->
      model =
        foo: deffered.promise
      async-ctrl := a-ctrl {$scope, model}


    it 'Should have all loading indicators for promises to true' !->
      expect ( $scope.loading
        |> R.values
        |> R.all
      ) .to.be.ok


    it 'Should update loading status as promises fullfill' !->
      expect $scope.loading.foo .to.be.ok

      deffered.resolve 4
      timeout.flush!

      expect $scope.loading.foo .to.be.not.ok


    it 'Should update total loading indicator as all promisess are fullfilled' !->
      expect $scope.any-loading .to.be.ok

      deffered.resolve 4
      timeout.flush!

      expect $scope.any-loading .to.be.not.ok

  describe "Multiple promises" (,) !->
    var a-def, b-def
    before-each !->
      a-def := $q.defer!
      b-def := $q.defer!
      model =
        foo: deffered.promise
        boo: b-def.promise
        a: a-def.promise

      async-ctrl := a-ctrl {$scope, model}

    it 'Should continue loading if not all promises are fullfilled' !->
      a-def.resolve 66
      deffered.resolve 44
      timeout.flush!

      expect $scope.any-loading .to.be.ok

    it 'Should stop loading if all promisees are done' !->
      a-def.resolve 66
      deffered.resolve 44
      b-def.resolve 41
      timeout.flush!

      expect $scope.any-loading .to.be.not.ok

  describe "Combination of promise and plain value" (,) !->

    before-each !->
      model =
        foo: deffered.promise
        bar: 34
      async-ctrl := a-ctrl {$scope, model}


    it 'Should update loading status for only promises' !->
      expect $scope.loading.bar .to.be.not.ok
      expect $scope.loading.foo .to.be.ok
      expect $scope.any-loading .to.be.ok

      deffered.resolve 4
      timeout.flush!

      expect $scope.loading.bar .to.be.not.ok
      expect $scope.loading.foo .to.be.not.ok
      expect $scope.any-loading .to.be.not.ok

  describe 'Model values' (,) !->
    before-each !->
      model =
        foo: deffered.promise
        bar: 4

      async-ctrl := a-ctrl {$scope, model}

    it 'Should attach non-promises right away' !->
      expect $scope.model.bar .to.be.equal 4

    it 'Should attach promis results as they are resolved' !->
      expect $scope.model.foo .to.be.not.ok

      deffered.resolve 44
      timeout.flush!

      expect $scope.model.foo .to.be.equal 44

  describe 'Error Handling' (,) !->
    before-each !->
      model =
        foo: deffered.promise

      async-ctrl := a-ctrl {$scope, model}

    it 'Should hide error object if there are no errors' !->
      expect $scope.any-error .to.be.not.ok
      expect $scope.errors .to.be.eql {}

    it 'Should attach error info associated with given key if error occurs' !->
      deffered.reject 'no-reason'
      timeout.flush!
      expect $scope.errors.foo .to.be.equal 'no-reason'
      expect $scope.any-error .to.be.ok

    it 'Should also be true for object errors' !->
      err = do
        reason: 'NOREASON'
      deffered.reject err

      timeout.flush!
      expect $scope.errors.foo .to.be.eql err


    describe 'Mix of Errors and promises' (,) !->
      var other-def
      before-each !->
        other-def := $q.defer!
        model =
          foo: deffered.promise
          boo: other-def.promise

        async-ctrl := a-ctrl {$scope, model}

      it 'Should indicate loading and error if both exist' !->
        deffered.reject 'no-reason'
        timeout.flush!

        expect $scope.any-error .to.be.ok
        expect $scope.any-loading .to.be.ok

        expect $scope.loading.foo .to.be.not.ok
        expect $scope.loading.boo .to.be.ok

      it 'Should stop loading if one promise is resolved and other is not' !->
        deffered.reject 'no-reason'
        other-def.resolve 42

        timeout.flush!

        expect $scope.any-error .to.be.ok
        expect $scope.any-loading .to.be.not.ok

        expect $scope.loading.foo .to.be.not.ok
        expect $scope.loading.boo .to.be.not.ok

      it 'Should stop loading if all promises result in an error' !->
        deffered.reject 'no-reason'
        other-def.reject 'neither'
        timeout.flush!

        expect $scope.any-error .to.be.ok
        expect $scope.any-loading .to.be.not.ok

        expect $scope.loading.foo .to.be.not.ok
        expect $scope.loading.boo .to.be.not.ok
