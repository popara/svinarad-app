angular.module "svinarad.poslodavac"
.config <[stateHelperProvider authenticatedOnly]> ++ (state-helper-provider, authenticatedOnly) !->
  s = state-helper-provider.state
  s do
    parent: 'app'
    name: 'job'
    url: '/job/:id'
    template-url: 'app/poslodavac/routes/job/job.html'
    controller: 'AsyncModel'
    resolve:
      model: <[JobById $stateParams PickWorker reviewWorker dismissWorker]> ++ (j, sp, pw, rw, dw) -> do
        job: (j sp.id ).$loaded!
        pickworker: pw
        review-worker: rw
        dismiss-worker: dw
