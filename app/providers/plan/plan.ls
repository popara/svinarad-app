
/**
 * User: popara
 * Date: 4/9/15
 * Time: 4:46 PM
 */
{concat, values, map, head, pairs-to-obj, keys} = require 'prelude-ls'

angular.module "jonny.providers"
.factory 'Plan' <[fo]> ++ (fo) -> (user-id) -> fo "plan/#{user-id}"
.factory 'Organizers' <[Profile Categories]> ++ (Profile, Categories) ->
  org =
    user: Profile.get!
    categories: Categories

  org
.factory 'PlanCategory' <[fo EntryBuilder]> ++ (fo, EB) -> (id, category) -> fo "plan/#{id}/categories/#{category}" (do
  new-entry: EB
)
.factory 'Categories' <[fa]> ++ (fa) -> fa 'categories'
.factory 'Category' <[fo]> ++ (fo) -> -> fo ['categories', it].join '/'
.factory 'CategoriesObject' <[fo]> ++ (fo) -> fo 'categories'
.directive "planBuilder" <[answersPerCategory Notifications UserProfile]> ++ (apc, Notifs, profile)  -> (do
  restrict: 'E'
  template-url: 'app/providers/plan/plan-builder.html'
  scope:
    client: \=
    plan: \=
    answers: \=
    questions: \=
    categories: \=

  link: (scope) !-> let categories = scope.categories, questions = scope.questions, answers = scope.answers
    p =  profile!
    get-answers = apc questions, answers
    prep-answers = map -> [it.$id, get-answers it.$id]

    scope.visible = (head categories).$id
    scope.set-visible = (id) !-> scope.visible = id
    scope.prepedAnswers = pairs-to-obj prep-answers categories

    scope.submit-plan = (plan) !->
      if confirm("Are you sure you want to submit this plan?")
      then
        plan.ready = true
        plan.$save!
        scope.client.fullfilled = true
        scope.client.$save!

        if not p.earned
        then p.earned = 0

        p.earned += 40
        p.$save!

        Notifs.plan-ready scope.client, p
        alert "Plan Submited to #{scope.client.name}"
)

.directive "planCategory" <[PlanCategory timestamp QandA convertDetails]> ++ (PlanCategory, timestamp, qa, convertDetails) -> (do
  restrict: 'E'
  template-url: 'app/providers/plan/plan-category.html'
  scope:
    folded: \=
    toggle: \&
    category: \=
    plan: \=
    answers: \=
  link: (scope) !-> let plan = scope.plan, category = scope.category, answers = scope.answers
    scope.qa = qa answers
    model = PlanCategory plan, category.$id
    scope.model = model
    scope.entry = model.new-entry!
    new-id = timestamp

    empty = ->
      it.id = null
      it.venue = null
      it.note = null
      it

    scope.toggle-fold = -> scope.toggle {id: scope.category.$id}
    scope.show-tips = -> scope.tips = true
    scope.hide-tips = -> scope.tips = false


    scope.set-entry = (e, id) !->
      scope.entry = e
      scope.entry.id = id if id


    scope.save-entry = -> let entry = scope.entry
      entry.id = new-id! if not entry.id
      model[entry.id] = entry
      model.$save!then !->
        scope.entry = model.new-entry!
        scope.ac = {}
    scope.cancel-editing = -> let entry = scope.entry
      switch
      | entry.id => scope.entry = null
      | _ => scope.entry = empty entry

    convert <- convertDetails.then
    scope.set-venue = (v) ->
      switch
      | v => convert v .then !-> scope.entry.venue = it
      | _ => scope.entry.venue = null
)

.directive "unfoldedCategory" -> (do
  restrict: 'A'
  priority: 10
  link: (scope, elem) !-> scope.unfolded = true
)

.directive "manualAdd" -> (do
  restrict: 'E'
  template-url: 'app/providers/plan/manual-add.html'
  scope:
    entry: \=
    save: \&
    cancel: \&
  link: (scope) !->
    scope.save-it = scope.save
    scope.cancel-it = scope.cancel
)
.directive "entryForm" <[Places]> ++ (Places) -> (do
  restrict: 'E'
  template-url: 'app/providers/client/entry-form.html'
  scope:
    entry: \=
    save: \&
    cancel: \&
    category: \=
    set-venue: \&
  link: (scope) !-> let entry = scope.entry
    scope.ac = {}
    scope.manual =
      | entry && entry.venue => not entry.venue.aid
      | _ => false

    scope.save-it = scope.save
    scope.set-v = (venue) ->
      scope.ac.text = if venue then venue.name else ''
      scope.set-venue {venue}
    scope.cancel-it = ->
      scope.manual = false
      scope.cancel!

    search <- Places.then
    scope.venues = search

)
