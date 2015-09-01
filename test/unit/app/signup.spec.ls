
describe "Critical Path Flow" (,) !->
  # Signup page
  # Email and FB
  # NOTIFY
  # Matching
  # Select expert
  # Pay
  # NOTIFY
  # Waiting room

  before-each module "jonny.client"

  it "Should not break" !->
    1.should.be.equal 1
