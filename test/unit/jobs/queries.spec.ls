describe 'Mocking Queries' (,) !->
  var fa, time
  finish = (fire-obj) !->
    fire-obj.$ref!flush!
    time.flush!


  before-each module 'app.base'
  before-each MockFirebase.override
  before-each inject (_fa_, _$timeout_) !->
      fa := _fa_
      time := _$timeout_

  it 'Should be sensitive to Mocks' !->
    var fa

    greet = []

    ref = new Firebase "https://svinarad.firebaseio.com/nexsto"

    do
      snap <-! ref.on 'child_added'
      greet.push snap.val!

    ref.push do
      greet: 'Prvo'

    ref.push do
      greet: "Drugo"

    ref.flush!

    expect greet.length .to.equal 2


  it 'Should work with ng firebase' (done) !->
    tp = fa 'test-point'

    do
      <- tp.$loaded
      expect tp.length .to.equal 1
      done!

    r  = tp.$ref!

    r.push do
      foo: 4

    finish tp

  it 'Should allow adding through ng firebase' !->
    tp = fa 'test-point'

    tp.$add do
      foo: 5

    finish tp

    expect tp.length .to.equal 1

  describe 'Open Jobs' (,) !->
    var oj
    before-each inject (_OpenJobs_) !-> oj := _OpenJobs_

    it 'Should output only open jobs' !->

      oj.$ref!push do
        status: 'open'

      oj.$ref!push do
        status: 'dva'

      finish oj

      oj.length.should.equal 2
