describe "MyJobs" (,) !->
  var myjobs, fire, timeout, fa, jstates, employer

  before-each MockFirebase.override
  before-each module "svinarad.poslodavac"
  before-each inject (_MyJobs_, _BaseFireRef_, _$timeout_, _fa_, _JobState_) !->
    myjobs := _MyJobs_
    fire := _BaseFireRef_
    timeout := _$timeout_
    fa := _fa_
    jstates := _JobState_

    employer :=
      $id: \empid
      name: 'El Employero'
      rating: 99

    fire.change-auth-state do
      uid: employer.$id
      provider: 'simplelogin'
      token: 'aaa'
      expires:  Math.floor(new Date() / 1000) + 24 * 60 * 60

    fire.flush!

  before-each !->
    draft = fa 'jobs/#{jstates.draft}'
    open = fa 'jobs/#{jstates.open}'
    drafted = fa 'jobs/#{jstates.drafted}'

    draft.$add do
      employer_id: employer.$id
      title: 'First'
      status: jstates.draft

    draft.$add do
      employer_id: 'Otro'
      title: 'Sec'
      status: jstates.draft

    open.$add do
      employer_id: employer.$id
      title: 'OPen job'
      status: jstates.open

    open.$add do
      employer_id: employer.$id
      title: 'Other open job'
      status: jstates.open

    drafted.$add do
      employer_id: 'somebody'
      title: 'Nvm'
      status: jstates.drafted

    fire.flush!

  it "Should load jobs from all states only for that employer" !->
    mj = myjobs
    
