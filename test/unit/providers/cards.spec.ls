describe "Cards" (,) !->
  var card-builder
  var deck-builder
  var $provide
  var presets
  before-each module \jonny.providers

  before-each inject (_cardBuilder_, _deckBuilder_, _Presets_) !->
    card-builder := _cardBuilder_
    deck-builder := _deckBuilder_
    presets := _Presets_

  it "Should build a card" !->
    u = card-builder 'test-cat'

    u.entry.should.be.a \object
    u.category.should.be.equal 'test-cat'


describe "Applying Deck" (,) !->
  var appl

  before-each module \jonny.providers

  before-each inject (_ApplyDeckOnPlan_) !->
    appl := _ApplyDeckOnPlan_

  it "Should build apply plan with a deck" !->
    plan = do
      $save: !->

    deck =
      name: 'testdeck'
      cards:
        a1:
          category: 'a'
          entry: {foo: 5}
        a2:
          category: 'a'
          entry: {foo: 4}
        b1:
          category: 'b'
          entry: {foo: 1}

    u = appl deck, plan

    plan.categories.should.be.a \object

describe "Applying Cards" (,) !->
  var appl
  var check

  before-each module \jonny.providers

  before-each inject (_ApplyCardOnPlan_, _CardInPlan_) !->
    appl := _ApplyCardOnPlan_
    check := _CardInPlan_

  it "Should build apply plan with a deck" !->
    plan = do
      $save: !->

    card =
      category: 'a'
      entry: {foo: 5}

    appl card, plan

    plan.categories.a.should.be.a \array
    plan.categories.a.length.should.be.equal 1

  it "Should say no when plan is empty" !->
    plan = {}
    card = {}

    check card, plan .should.not.be.ok


  it "Should say yes when card's entry is in the plan" !->
    v  = -> {name: it}
    v1 = v 'pera'

    plan =
      categories:
        a: [{venue: v1}]
    card =
      category: \a
      entry:
        venue: v1


    check card, plan .should.be.ok


  it "Should say no when card's entry is not in the plan" !->
    v  = -> {name: it}
    v1 = v 'pera'
    v2 = v 'miki'
    plan =
      categories:
        a: [{venue: v1}]

    card =
      category: \a
      entry:
        venue: v2


    check card, plan .should.not.be.ok
