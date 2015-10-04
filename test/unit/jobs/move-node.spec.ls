describe "Moving the node" (,) !->
  var fa, time, move
  finish = (fire-obj) !->
    fire-obj.$ref!flush!
    time.flush!

  finish-plain = (.flush!)

  before-each module 'app.base'
  before-each MockFirebase.override
  before-each inject (_Move_) !-> move := _Move_

  before-each inject (_fa_, _$timeout_) !->
      fa := _fa_
      time := _$timeout_
