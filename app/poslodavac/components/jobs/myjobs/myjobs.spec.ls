describe "MyJobs" (,) !->
  var myjobs, fire, timeout, auth

  before-each MockFirebase.override
  before-each module "svinarad.poslodavac"
  before-each inject (_MyJobs_, _BaseFireRef_, _$timeout_) !->
    myjobs := _MyJobs_
    fire := _BaseFireRef_
    timeout := _$timeout_

  before-each inject (_Auth_) !-> auth := _Auth_

  it "Should seek the auth" !->

    fire.change-auth-state do
      uid: 'auth-uid'
      provider: 'simplelogin'
      token: 'aaaa'
      expires: Math.floor(new Date() / 1000) + 24 * 60 * 60


    fire.flush!
    timeout.flush!

    expect myjobs! .to.equal 'auth-uid'
