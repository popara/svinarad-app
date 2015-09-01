describe "Authentication Stuff" (,) !->
  var auth
  before-each module "jonny.providers"
  before-each inject (_Authentication_) !-> auth := _Authentication_

  it "Show some love to Reset password" !->
    expect auth.reset-method .to.be.ok

  it "Should can create user" !->
    expect auth.create-user .to.be.ok

  it "Should have login method" !->
    expect auth.login .to.be.ok
