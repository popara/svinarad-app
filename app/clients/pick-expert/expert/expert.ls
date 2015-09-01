{find} = require \prelude-ls

angular.module "jonny.client"
.directive "expertProfile" <[LangageSkills]> ++ (LS) -> (do
  restrict: 'E'
  template-url: 'app/clients/pick-expert/expert/expert.html'
  scope:
    expert: '='

  link: (scope) !->
    scope.language = LS
    scope.count = ->
     | it => (Object.keys it ).length
     | _ => 0
)
.factory "LangageSkills" <[Languages]> ++ (L) ->
  skills = <[Native Basic Notions Professional Fluent]>

  get-name = (lang) -> L[lang].label
  get-skill = (level) -> skills[level]

  (do
    name: get-name
    skills: skills
    proficiency: get-skill
  )

.factory "Languages" -> do
  english:
    label: 'English'
  french:
    label: 'French'
  italian:
    label: 'Italian'
  spanish:
    label: 'Spanish'
  portuguese:
    label: 'Portuguese'
  german:
    label: 'German'
  dutch:
    label: 'Dutch'
  russian:
    label: 'Russian'
  euskara:
    label: 'Euskara'
  hebrew:
    label: 'Hebrew'
