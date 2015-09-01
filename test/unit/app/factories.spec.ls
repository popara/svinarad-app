describe 'Factories' (,) !->
  levels = null
  time-left = null
  $interval = null
  $timeout = null
  before-each module "jonny.admin"
  before-each inject (_Levels_, _TimeLeft_, _$interval_, _$timeout_) !->
    levels := _Levels_
    time-left := _TimeLeft_
    $interval := _$interval_
    $timeout := _$timeout_

  it 'should exist' !->
    expect levels .to.be.ok


  describe 'TimeLeft' (,) !->
    it 'should accept moment parameters' (done) !->
      @timeout 8000

      expect-time = (unit, ex-time, duration) !-->
        duration.get unit .should.be.below ex-time
      expect-secs = expect-time 'milliseconds'

      test-unit = (sec) -> -> expect-secs sec, u.timeleft

      u = time-left moment!add 5 's'

      $interval.flush 1000
      test-unit 4000

      $interval.flush 1000
      test-unit 3000

      done!

    it 'Should notify when done' (done) !->
      u = time-left (moment!add 0.5 's'), done
      set-timeout (!->
        $interval.flush 1000
      ), 1000
