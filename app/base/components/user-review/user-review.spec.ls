describe "user-review" (,) !->
  var user-review
  before-each module "app.base"
  before-each inject (_user-review_) !-> user-review := _user-review_

  it "Should be user-review" !->
    expect user-review .to.be.ok
