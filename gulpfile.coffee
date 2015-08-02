coffee = require 'gulp-coffee'
del = require 'del'
espower = require 'gulp-espower'
gulp = require 'gulp'
gutil = require 'gulp-util'
mocha = require 'gulp-mocha'
run = require 'run-sequence'
sourcemaps = require 'gulp-sourcemaps'
watch = require 'gulp-watch'

dirs =
  dist: './lib/'                       # javascript files
  src: './src/'                        # coffee-script files
  test: './test/'                      # coffee-script files for testing
  tmpSrc: './.tmp/'                    # compiled javascript files
  tmpTest: './.tmp/'                   # compiled javascript files for testing

ignoreError = (stream) ->
  stream.on 'error', (e) ->
    gutil.log e
    @emit 'end'

gulp.task 'build', (done) ->
  run.apply run, [
    'build:coffee'
    done
  ]

gulp.task 'build(dev)', (done) ->
  run.apply run, [
    'build:coffee(dev)'
    done
  ]

gulp.task 'build:coffee', ->
  gulp.src dirs.src + '**/*.coffee'
  .pipe coffee(bare: true)
  .pipe gulp.dest dirs.dist

gulp.task 'build:coffee(dev)', ->
  gulp.src dirs.src + '**/*.coffee'
  .pipe sourcemaps.init()
  .pipe ignoreError coffee()
  .pipe sourcemaps.write()
  .pipe gulp.dest dirs.tmpSrc

gulp.task 'build-test', ->
  gulp.src dirs.test + '**/*.coffee'
  .pipe sourcemaps.init()
  .pipe coffee()
  .pipe espower()
  .pipe sourcemaps.write()
  .pipe gulp.dest dirs.dist

gulp.task 'build-test(dev)', ->
  gulp.src dirs.test + '**/*.coffee'
  .pipe sourcemaps.init()
  .pipe ignoreError coffee()
  .pipe ignoreError espower()
  .pipe sourcemaps.write()
  .pipe gulp.dest dirs.tmpTest

gulp.task 'clean', (done) ->
  del [
    dirs.tmpSrc
    dirs.tmpTest
    dirs.dist
  ], done
  null

gulp.task 'default', (done) ->
  run.apply run, [
    'clean'
    'build'
    done
  ]
  null

gulp.task 'test', ['build', 'build-test'], ->
  gulp.src dirs.dist + '**/*-test.js'
  .pipe mocha()

gulp.task 'test(dev)', ->
  gulp.src dirs.tmpTest + '**/*-test.js'
  .pipe ignoreError mocha()

gulp.task 'watch', ['build(dev)'], ->
  watch [
    dirs.src + '*.coffee' # for gulp-watch bug
    dirs.src + '**/*.coffee'
    dirs.test + '*.coffee' # for gulp-watch bug
    dirs.test + '**/*.coffee'
  ], ->
    run.apply run, [
      'build:coffee(dev)'
      'build-test(dev)'
      'test(dev)'
      ->
    ]
