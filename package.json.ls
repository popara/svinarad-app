#!/usr/bin/env lsc -cj
_: 'Do not edit, generated from package.json.ls'
author: 'Zeljko Nesic'
name: 'SviNaRad'
description: 'Frontend for Svinarad'
version: '0.9.5'
homepage: 'https://svinarad.com/'
engines:
  node: '0.10.x'
  npm: '1.3.x'
scripts:
  republish: 'lsc -dcj -r ./gulpfile.ls ./test/karma.deps.ls  package.json.ls && lsc -cj -r ./bower.ls app/**/bower.json.ls'
  build: 'gulp --require livescript build'
  dist: 'gulp --require livescript build --production'
  dev: 'gulp --require livescript dev'
  test: 'gulp --require livescript test:unit'
  protractor: 'gulp --require livescript test:e2e'
  seed: 'gulp --require livescript seed'
  fire: 'gulp --require livescript firetrials'
dependencies: {}
devDependencies: gulpfile.gulp-deps <<<
  deps <<< do
    'livescript': '1.4.0'
    'bower': '^1.4.1'
    'protractor': '^2.1.0'
