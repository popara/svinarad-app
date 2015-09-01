P = require \prelude-ls

describe "Game" (,) !->
  var about
  before-each module "jonny.client"
  before-each inject (_gameAboutDirective_) !->
    about := _gameAboutDirective_.0



  it "Should have work" !->
    about.link.should.be.a \function


describe "Random Salt" (,) !->
  var random-salt
  before-each module "jonny.client"
  before-each inject (_randomSalt_) !->
    random-salt := _randomSalt_


  it "Should output 6 or 7 chars salt" !->
    a = random-salt!
    expect a.length .to.be.least 6
    expect a.length .to.be.most 7

  it "Should not output two things twice" !->
    a = random-salt!
    b = random-salt!

    a.should.not.equal b
