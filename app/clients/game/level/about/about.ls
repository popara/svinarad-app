about-fn = (ao, eh, auth, scope, elem) !-->
  answer = eh
  scope.ans = answer
  scope.labels = -> it.1

  scope.ops = ao
  scope.toggle = (thing, value) -> let t = answer[thing], val = value.0
    if t and val is t
    then t = null
    else t = val
    answer[thing] := t

  scope.checked = (thing, value) -> answer[thing] is value.0

  scope.$on \answer !->
    scope.delegate {scope.question, answer}
    scope.$emit 'answered'

    if auth and not auth.signued-up answer.email
    then auth.signup-with-built-in-pass answer.email, answer.name

  if scope.init
  then
    v = scope.init.value
    _.merge answer, v


angular.module "jonny.client"
.directive 'gameAbout' <[Authentication AboutOptions ProfileHelper]> ++ (auth, ao, eh) -> (do
  restrict: 'E'
  template-url: 'app/clients/game/level/about/about.html'
  scope:
    question: '='
    delegate: '&'
    init: '='
    isValid: '='

  link: about-fn ao, eh, auth
)
.directive "gameAboutDetails" <[AboutOptions ProfileHelper]> ++ (ao, ph) -> (do
  restrict: 'E'
  template-url: 'app/clients/game/level/about/about-details.html'
  scope:
    question: '='
    delegate: '&'
    init: '='
  link: about-fn ao, ph, false

)

.factory 'AboutOptions' <[Genders Preference]> ++ ((g, p) -> do
  genders: g
  preferences: p
)
.factory "ProfileHelper" -> do
  email: ''
  name: ''
  age: ''
  gender: ''
  country: ''
