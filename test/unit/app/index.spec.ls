describe "Index page" (,) !->

  it "Should mark where he came from" !->
    expect from-key .to.be.equal \__ffff
    c = Cookies from-key
    expect c .to.be.equal ''
