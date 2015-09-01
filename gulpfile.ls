{map} = require \prelude-ls
require! <[gulp gulp-util gulp-stylus gulp-livereload gulp-livescript streamqueue gulp-if gulp-plumber]>
require! <[gulp-bower main-bower-files gulp-filter gulp-uglify gulp-csso]>
require! <[gulp-concat gulp-json-editor gulp-commonjs gulp-insert gulp-order]>
require! <[gulp-angular-templatecache gulp-jade del]>
yaml = require 'gulp-yaml'
run = require 'gulp-run'
gutil = gulp-util
require! <[nib jeet rupture]>
{autoprefixer} = require 'autoprefixer-stylus'
{protractor, webdriver_update} = require 'gulp-protractor'

plumber = ->
  gulp-plumber !->
      gutil.beep!
      gutil.log gutil.colors.red it.toString!


dev = gutil.env._.0 is \dev
production = not dev

bs = require \browser-sync .create!
google-analytics = 'UA-6621805-2'
var http-server

app-js = (app-name, root, task-name) ->
  gulp.task task-name, ->
    base = "./app/base/**/*.ls"
    baseinit = "./app/base/base.ls"
    init = "./app/#{app-name}/app.ls"
    rest = "./app/#{app-name}/**/*.ls"

    app = gulp.src [baseinit, base, init, rest]
      .pipe plumber!
      .pipe gulp-filter -> it.path is not /\.json.ls$/
      .pipe gulp-livescript {prelude: true}
      .pipe gulp-concat "app.js"
      .pipe gulp-if production, gulp-uglify!
      .pipe gulp.dest "#{root}/#{app-name}/js/"
      .pipe bs.stream!


vendor-js = (app-name, root, task-name) ->
  gulp.task task-name, ["#{app-name}:bower"], ->
    bower =
      gulp.src main-bower-files do
        paths:
          bowerDirectory: "./bower_components/#{app-name}/"
          bowerJson: "./app/#{app-name}/bower.json"
      .pipe gulp-filter -> it.path is /\.js$/

    s = streamqueue {+objectMode}
      .done bower, gulp.src "app/#{app-name}/vendor/scripts/*.js"
      .pipe gulp-concat "vendor.js"
      .pipe gulp-if production, gulp-uglify!
      .pipe gulp.dest "./#{root}/#{app-name}/js"
      .pipe gulp-if dev, bs.stream!

vendor-style = (app-name, root, task-name) ->
  gulp.task "#{app-name}:fonts:vendor" ["#{app-name}:bower"], ->
    gulp.src main-bower-files do
      paths:
        bowerDirectory: "./bower_components/#{app-name}/"
        bowerJson: "./app/#{app-name}/bower.json"
    .pipe gulp-filter -> it.path is /\.(woff|ttf|woff2|svg|eot)$/
    .pipe gulp.dest "./#{root}/fonts"

  gulp.task task-name, ["#{app-name}:fonts:vendor"], ->
    bower =
      gulp.src main-bower-files do
        paths:
          bowerDirectory: "./bower_components/#{app-name}/"
          bowerJson: "./app/#{app-name}/bower.json"
      .pipe gulp-filter -> it.path is /\.css$/


    fonts = gulp.src "app/${app-name}/vendor/styles/**/*.*"
      .pipe gulp-filter -> it.path is /\.(woff|ttf|woff2|svg|eot)$/
      .pipe gulp.dest "./#{root}/fonts"

    s = streamqueue {+objectMode}
      .done bower, gulp.src "app/#{app-name}/vendor/styles/**/*.css"
      .pipe gulp-concat "vendor.css"
      .pipe gulp-if production, gulp-csso!
      .pipe gulp.dest "./#{root}/#{app-name}/css"
      .pipe gulp-if dev, bs.stream!

app-style = (app-name, root, task-name) ->
  gulp.task task-name, ->
    base = "app/base/index.styl"
    styl = gulp.src [base, "app/#{app-name}/index.styl"]
      .pipe gulp-if dev, plumber!
      .pipe gulp-stylus use: [nib!, jeet!, rupture!]
      .pipe gulp-if production, gulp-csso!
      .pipe gulp.dest "./#{root}/#{app-name}/css"
      .pipe bs.stream!

templates = (app-name, root, task-name) ->
  gulp.task "#{task-name}:index" ->
    pretty = gutil.env.env isnt \production
    gulp.src ["./app/#{app-name}/#{app-name}.jade"]
      .pipe gulp-jade do
        pretty: pretty
        locals:
          googleAnalytics: google-analytics
          dev: dev
          production: production
      .pipe gulp.dest "./#{root}"

  gulp.task task-name, ["#{task-name}:index"] ->
    gulp.src ["app/base/**/*.jade", "app/#{app-name}/**/*.jade", "!app/#{app-name}/*.jade"]
      .pipe plumber!
      .pipe gulp-jade!
      .pipe gulp-angular-templatecache "templates.js" do
        base: process.cwd()
        filename: "templates.js"
        module: "#{app-name}.templates"
        standalone: true
      .pipe gulp.dest "./#{root}/#{app-name}/js"
      .pipe bs.stream!

assets = (app-name, root, task-name) ->
  gulp.task task-name, ->
    gulp.src "app/#{app-name}/assets/**"
      .pipe gulp.dest root

bower = (app-name, root, task-name) ->
  gulp.task task-name, ->
    gulp-bower do
      directory: "../../bower_components/#{app-name}"
      cwd: "./app/#{app-name}/"

gulp-tasks = (app-name, root, use-vendor-style=false) ->
  f = (a, b) -> a app-name, root, b
  tasks =
    * "#{app-name}:bower" bower
    * "#{app-name}:js:vendor" vendor-js
    * "#{app-name}:js:app" app-js

  tasks = tasks ++ [
    * "#{app-name}:css:vendor" vendor-style
  ] if use-vendor-style

  tasks = tasks ++ [
    * "#{app-name}:css:app" app-style
    * "#{app-name}:templates" templates
    * "#{app-name}:assets" assets
  ]

  tasks  |>
  map (a) -> let name = a.0, task = a.1
    f task, name
    name

eyes-on = (root, app-name) ->
  gulp.watch "./app/#{root}/**/*.ls" ["#{app-name}:js:app"]
  gulp.watch "./app/#{root}/**/*.styl" ["#{app-name}:css:app"]
  gulp.watch "./app/#{root}/**/*.jade" ["#{app-name}:templates"]

eyes-on-app = (app-name) ->
  eyes-on \base app-name
  gulp.watch "./app/#{app-name}/**/*.ls", ["#{app-name}:js:app"]
  gulp.watch "./app/#{app-name}/**/*.styl" ["#{app-name}:css:app"]
  gulp.watch "./app/#{app-name}/**/*.jade" ["#{app-name}:templates"]



index-tasks = (root, source) ->
  gulp.task "index:templates" ->
    pretty = gutil.env.env isnt \production
    gulp.src ["./app/#{source}/*.jade"]
      .pipe gulp-jade do
        pretty: pretty
        locals:
          googleAnalytics: google-analytics
          dev: dev
          production: production
      .pipe gulp.dest "./#{root}"
      .pipe bs.stream!

  gulp.task "index:css" ->
    base = "./app/base/index.styl"
    gulp.src [base, "./app/#{source}/index.styl"]
      .pipe gulp-if dev, plumber!
      .pipe gulp-stylus use: [nib!, jeet!, rupture!]
      .pipe gulp-if production, gulp-csso!
      .pipe gulp.dest "./#{root}/css"
      .pipe bs.stream!

  gulp.task "index:scripts" ->
    gulp.src "app/#{source}/vendor/scripts/*.js"
      .pipe gulp-concat "vendor.js"
      .pipe gulp-if production, gulp-uglify!
      .pipe gulp.dest "./#{root}/js"
      .pipe gulp-if dev, bs.stream!

  gulp.task "index:js" ->
    gulp.src ["app/#{source}/**/*.ls"]
      .pipe plumber!
      .pipe gulp-filter -> it.path is not /\.json.ls$/
      .pipe gulp-livescript {prelude: true}
      .pipe gulp-concat 'index.js'
      .pipe gulp.dest "./#{root}/js"
      .pipe gulp-if dev, bs.stream!


  gulp.task 'index:assets' ->
    gulp.src "app/#{source}/assets/**" {base: "./app/#{source}/assets/"}
      .pipe gulp.dest root

  <[index:templates index:css index:scripts index:js index:assets]>

config-task = (root) ->
  task-name = "configuration"
  prod-file = 'app/config.yaml'
  dev-file = 'app/config.dev.yaml'
  conf-file =
    if production
    then prod-file
    else dev-file

  gulp.task task-name, ->
    gulp.src conf-file
      .pipe yaml!
      .pipe gulp-json-editor (json) ->
        for key of json when process.env[key]?
          json[key] = that
        json.dev = dev
        json.production = production
        json
      .pipe gulp-insert.prepend 'CONFIG = '
      .pipe gulp-insert.append ';'
      .pipe gulp-concat 'cfg.js'
      .pipe gulp.dest "./#{root}/js"

  [task-name]
  
root = "_public"
apps = <[clients providers admin]>

indexs = index-tasks root, "website"

client = gulp-tasks "clients" root
provider = gulp-tasks "providers" root, true
admin = gulp-tasks "admin" root, true
canvas = gulp-tasks "canvas" root, true
configuration = config-task root

apps = client ++ provider ++ admin ++ canvas
all-tasks = configuration ++ indexs ++ apps
clean-task = 'clean'
gulp.task clean-task, (done) !->
  del ['_public/**/*'], done

eyes-for-index = !->
  gulp.watch './app/base/**/*.ls' <[index:js]>
  gulp.watch './app/base/**/*.styl' <[index:css]>
  gulp.watch './app/base/**/*.jade' <[index:templates]>
  gulp.watch './app/website/**/*.ls' <[index:js]>
  gulp.watch './app/website/**/*.styl' <[index:css]>
  gulp.watch './app/website/**/*.jade' <[index:templates]>
  gulp.watch './app/website/vendor/scripts/**/*.js' <[index:scripts]>

gulp.task 'build' all-tasks, !->

gulp.task 'dev' all-tasks, (done) ->
  gulp.start 'httpServer'

  <[client provider admin canvas]>
  |> map eyes-on-app

  eyes-for-index!

  require 'karma' .server.start {
    config-file: __dirname + '/test/karma.conf.ls',
  }, ->
    done!
    process.exit!




gulp.task 'webdriver_update' webdriver_update

gulp.task 'protractor' <[webdriver_update httpServer]> ->
  gulp.src ["./test/e2e/app/*.ls"]
    .pipe plumber!
    .pipe protractor configFile: "./test/protractor.conf.ls"

gulp.task 'test:e2e' <[protractor]> ->
  http-server.close!

gulp.task 'compiletrials' ->
  gulp.src 'fire-trials.yaml'
    .pipe plumber!
    .pipe yaml!
    .pipe gulp.dest '.'

gulp.task 'blazerules' ->
  run 'blaze rules.yaml' .exec!
    .pipe plumber!

gulp.task 'runtrials' ->
  run 'node ./node_modules/targaryen/bin/targaryen.js rules.json fire-trials.json --debug' .exec!
    .pipe plumber!


gulp.task 'firetrials' <[blazerules compiletrials]> ->
  gulp.watch 'fire-trials.yaml' <[compiletrials]>
  gulp.watch 'rules.yaml' <[blazerules]>




export gulp-deps = do
  "lodash": "^3.2.0"
  "del": "^1.2.0"
  "yargs": "^3.0.4"
  "gulp": "^3.8.0"
  "gulp-util": '^3.0.1'
  "gulp-exec": '^2.1.0'
  "gulp-file": '^0.2.0'
  "gulp-protractor": '^0.0.11'
  "gulp-livescript": '^1.0.3'
  "gulp-stylus": '^2.0.1'
  "gulp-concat": '^2.4.0'
  "gulp-jade": '^1.0.0'
  "gulp-angular-templatecache": '^1.6.0'
  "gulp-bower": '~0.0.2'
  "main-bower-files": '^1.0.1'
  "gulp-uglify": '^1.2.0'
  "gulp-csso": '~0.2.6'
  "gulp-filter": '^1.0.1'
  "gulp-mocha": '^1.0.0'
  "gulp-livereload": '^3.8.0'
  "gulp-json-editor": "^2.0.2"
  "gulp-commonjs": "^0.1.0"
  "gulp-insert": "^0.4.0"
  "gulp-if": '^1.2.4'
  "gulp-plumber": "^0.6.5"
  "autoprefixer-stylus": "^0.5.0"
  "streamqueue": '^0.1.1'
  "connect-livereload": '0.5.3'
  "tiny-lr": '^0.1.1'
  "express": '^4.8.8'
  "http-proxy": "0.10.3"
  "nib": '^1.1.0'
  "jeet": '^6.1.2'
  "rupture": "^0.6.1"
  "browser-sync": "^2.6.11"
  "connect-modrewrite": "^0.8.1"
  "prelude-ls": "1.1.2"
  "gulp-order": "1.1.1"
  "gulp-yaml": "0.2.4"
  "gulp-run": "1.6.8"
