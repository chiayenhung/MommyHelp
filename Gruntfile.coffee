fs = require 'fs'
# jade = require 'jade'

module.exports = (grunt) ->

  # load external grunt tasks
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-express'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-env'
  grunt.loadNpmTasks 'grunt-mocha-test'

  DEV_PATH = "development"
  PRODUCTION_PATH = "public"


  grunt.initConfig

    mochaTest:
      controllers:
        options:
          reporter: 'spec'
        src: ['test/*']

    express:
      test:
        options:
          server: './server/server'
          port: 5000
      development:
        options:
          server: './server/server'
          port: 3000  

    clean:
      development: "#{PRODUCTION_PATH}"
      js: ["#{PRODUCTION_PATH}/js", "{PRODUCTION_PATH}/js/main.js"]
      css: ["#{PRODUCTION_PATH}/css", "#{PRODUCTION_PATH}/css/main.css"]

    copy:
      imgs:
        src: "#{DEV_PATH}/imgs/*"
        dest: "#{PRODUCTION_PATH}/"

    sass:
      development:
        files: [
          expand: true
          cwd: "#{DEV_PATH}/sass"
          src: ['*.sass']
          dest: "#{PRODUCTION_PATH}/css"
          ext: ".css"
        ]  

    coffee:
      development:
        options:
          sourceMap: false
        files: [
          expand: true
          cwd: "#{DEV_PATH}/coffee"
          dest: "#{PRODUCTION_PATH}/js"
          src: ["*.coffee", "**/*.coffee"]
          ext: ".js"
        ]

    concat:
      js:
        src: ["#{DEV_PATH}/lib/js/*.js", "#{PRODUCTION_PATH}/js/*.js"]
        dest: "#{PRODUCTION_PATH}/main.js"
      css:
        src: ["#{DEV_PATH}/lib/css/*.css", "#{PRODUCTION_PATH}/css/*.css"]
        dest: "#{PRODUCTION_PATH}/main.css"

    watch:
      express: 
        files:  [ 'server/**/*.coffee' ]
        tasks:  ['express:development' ]
      sass:
        files: ['**/*.sass']
        tasks: [ 'clean:css', 'sass', 'concat:css']
      coffee:
        files: ['**/*.coffee']
        tasks: [ 'clean:js', 'coffee', 'concat:js']

    env:
      development:
        MONGO_URL: 'mongodb://localhost/mommyHelp'
      test:
        MONGO_URL: 'crowdSurge_test.db'

  grunt.registerTask 'test', [
    'env:test'
    'express:test'
    'mochaTest'
  ]


  grunt.registerTask 'default', [
    'clean'
    'env:development'
    'express:development'
    'sass'
    'coffee'
    'copy:imgs'
    'concat'
    'watch'
  ]
