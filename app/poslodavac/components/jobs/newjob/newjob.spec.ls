describe "Creating new Job" (,) !->
  var fa, fire, newjob, timeout, employer, jstatus

  before-each module 'svinarad.poslodavac'
  before-each MockFirebase.override
  before-each inject (_fa_) !-> fa := _fa_
  before-each inject (_NewJob_) !-> newjob := _NewJob_
  before-each inject (_BaseFireRef_) !-> fire := _BaseFireRef_
  before-each inject (_$timeout_) !-> timeout := _$timeout_
  before-each inject (_JobStatus_) !-> jstatus := _JobStatus_

  before-each !->
    employer :=
      $id: 'employer-id'
      name: 'El Employer'
      rating: 77

  it 'Should provide base object as model' !->
    j = newjob.spawn employer.$id, employer

    expect j.status .to.equal 'draft'
    expect j.employer_id .to.equal employer.$id
    expect j.employer.name .to.equal employer.name


  it 'Should save among drafts if specified' (done) !->
    j = newjob.spawn employer.$id, employer

    p = newjob.save j

    p.then (res-ref) !->
      expect res-ref.to-string!index-of 'jobs/draft' .to.be.gt -1
      done!

    fire.flush!
    timeout.flush!


  it 'Should save among open jobs if specified' (done) !->
    j = newjob.spawn employer.$id, employer
    j.status = jstatus.open
    p = newjob.save j

    p.then (res-ref) !->
      expect res-ref.to-string!index-of 'jobs/open' .to.be.gt -1
      done!

    fire.flush!
    timeout.flush!
