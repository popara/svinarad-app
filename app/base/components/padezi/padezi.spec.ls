describe "padezi" (,) !->
  var padezi
  before-each module "app.base"
  before-each inject (_padezi_) !-> padezi := _padezi_

  it "Should be padezi" !->
    expect padezi .to.be.ok
