{join, zip, last, split} = require \prelude-ls

angular.module "jonny.providers"
.factory "Profile" <[UserProfile]> ++ (user-profile) ->
  profile <- user-profile!$loaded
  profile.skills = [] if not profile.skills
  profile
.factory "LangageSkills" <[Languages]> ++ ((L) ->
  skills = <[Native Basic Notions Professional Fluent]>
  values = _.range 0 skills.length

  get-name = (lang) ->
    | L[lang] => L[lang].label
    | _ => lang

  get-skill = (level) -> skills[level]

  (do
    skills: zip values, skills
    get-name: get-name
    get-skill: get-skill
  )

)
.factory "Languages" -> (do
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
)

.factory "UploadEndpoint" ->
  if CONFIG.dev
  then "http://localhost:8000/api/upload"
  else "https://jonnyinc.herokuapp.com/api/upload"

.config <[stateHelperProvider]> ++ (shp) !->
  s = shp.state
  s (do
    name: 'profile'
    url: '/profile'
    template-url: 'app/providers/profile/profile.html'
    controller: 'ModelOptionsNext'
    resolve:
      model: 'Profile'
      options: <[LangageSkills Profile Upload UploadEndpoint Restangular $q fo]> ++ (LS, P, U, UEP, R, $q, fo) ->
        profile <- P.then
        (do
          language-skills: LS
          flow: (flow) -> let img = flow.0
            if img
            then
              ext = last (split '.' img.name)
              name = join '.' [profile.$id, ext]
              p = U.upload do
                url: UEP
                file: img
                file-name: name

              r <- p.then
              profile.pic = r.data
              profile.$save!

            else
              pr = $q.defer!
              pr.resolve yes
              pr.promise

          add-language: (lang) ->
            name = lang.name.to-lower-case!
            if not profile.languages
            then profile.languages = {}

            profile.languages[name] = lang.skill

            lang.name = ''
            lang.skill = 0

          remove-language: (lang) ->
            if profile.languages === {}
            then profile.languages = null


          save: (profile) -> profile.$save!
        )
      period: -> 1000
    data: {next: 'profile'}
  )
