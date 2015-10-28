require! 'fs'
require! 'path'

module.exports = (plop) !->
  get-folders = (src-path) ->
    file <- fs.readdir-sync src-path .filter
    fs.stat-sync path.join src-path, file
      .is-directory!

  app-folders = -> get-folders './app'

  target-app = -> do
    type: 'list'
    name: 'app'
    message: 'Choose target app'
    choices: app-folders!
    default: 2

  plop.set-generator 'component' (do
    description: 'AngularLS component'
    prompts:
      * target-app!
      * type: 'input'
        name: 'name'
        message: 'Name of component?'
        validate: (value) ->
          if /.+/ .test value
          then true
          else 'name is required'

    actions:
      * type: 'add'
        path: 'app/{{ dashCase app }}/components/{{ dashCase name }}/{{ dashCase name }}.spec.ls'
        template-file: './_plop/comp.spec.txt'
      * type: 'add'
        path: 'app/{{ dashCase app }}/components/{{ dashCase name }}/{{ dashCase name }}.ls'
        template-file: './_plop/comp.file.txt'

  )
  plop.set-generator 'directive' (do
    description: 'AngularLS Directive'
    prompts:
      * target-app!
      ...
    actions: []
  )
  plop.set-generator 'route' (do
    description: "UI-Router Route"
    prompts:
      * target-app!
      * type: 'input'
        name: 'route'
        message: 'State name'
      * type: 'input'
        name: 'url'
        message: 'URL for the state'
      * type: 'input'
        name: 'controller'
        message: 'Name of the controller?'
    actions:
      * type: 'add'
        path: 'app/{{ dashCase app }}/routes/{{ dashCase route }}/{{ dashCase route}}.spec.ls'
        template-file: './_plop/route.spec.txt'
      * type: 'add'
        path: 'app/{{ dashCase app }}/routes/{{ dashCase route }}/{{ dashCase route}}.ls'
        template-file: './_plop/route.txt'

      * type: 'add'
        path: 'app/{{ dashCase app }}/routes/{{ dashCase route }}/{{ dashCase route}}.jade'
        template-file: './_plop/route.tpl.txt'
        

  )
