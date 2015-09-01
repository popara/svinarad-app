describe "Waiting Room" (,) !->
  var state, $state, auth

  before-each module "jonny.client"
  before-each inject (_Auth_) !->
    auth := _Auth_
    auth.$get-auth = -> {uid: "simplelogin:1"}

  describe "Waiting Room Factory" (,) !->
    var factory, root, scope

    before-each inject (_waitingRoom_, _$root-scope_) !->
      factory := _waitingRoom_

    it "Expose expert and unread count" ->
      expect factory .to.be.ok
      factory.should.be.fulfilled


    it 'Expose Unseen count' !->
      factory.should.be.fulfilled
