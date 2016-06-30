require! <[
  gulp gulp-elm gulp-pug gulp-stylus gulp-rename gulp-livescript gulp-util gulp-plumber
  fs live-server nib rupture jeet]>

make-elm = ->
  gulp.src "src/*.elm"
    .pipe gulp-plumber!
    .pipe gulp-elm!
    .pipe gulp.dest './_public/js'

compile-pug = ->
  files = fs.readdir-sync (__dirname + "/src/")
    .filter (a) -> /elm$/.test a
    .for-each (file) ->
      gulp.src "./src/page.pug"
        .pipe gulp-plumber!
        .pipe gulp-rename file.to-lower-case!
        .pipe gulp-pug pug-opts file
        .pipe gulp.dest "./_public/"

pug-opts = (file) ->
  woext = file.substring 0 (file.length - 4)
  do
    locals:
      title: file
      css-target: "css/#{woext}.css"
      js-target: "js/#{woext}.js"
      js-target-init: "js/#{woext}-init.js"


compile-stylus = ->
  gulp.src "./src/styles/*.styl"
    .pipe gulp-plumber!
    .pipe gulp-stylus use: [nib!, jeet!, rupture!]
    .pipe gulp.dest './_public/css'


compile-ls = ->
  gulp.src "./src/init/*.ls"
    .pipe gulp-plumber!
    .pipe gulp-livescript!
    .pipe gulp.dest './_public/js'

copy-assets = ->
  gulp.src "./assets/**"
    .pipe gulp.dest "./_public/"
  gulp.src "./vendor/**"
    .pipe gulp.dest "./_public/js/"

start-live-server = ->
  live-server.start do
    port: 3777
    root: __dirname + "/_public/"
    wait: 400


dev = (done) ->
  gulp.watch "./src/**/*.elm" <[elm]>
  gulp.watch "./src/**/*.styl" <[stylus]>
  gulp.watch "./src/*.pug" <[pug]>
  gulp.watch "./src/init/*.ls" <[ls]>
  gulp.watch "./assets/**" <[assets]>
  gulp.watch "./vendor/**" <[assets]>
  start-live-server!


gulp.task "elm-init" gulp-elm.init
gulp.task "elm" ["elm-init"] make-elm
gulp.task "pug" compile-pug
gulp.task "stylus" compile-stylus
gulp.task "ls" compile-ls
gulp.task "assets" copy-assets
gulp.task "dev" <[elm pug stylus ls assets]> dev
