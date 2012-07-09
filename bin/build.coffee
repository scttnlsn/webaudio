rjs = require '../node_modules/.bin/r.js'

config =
    baseUrl: 'src'
    mainConfigFile: 'src/main.js'
    name: 'main'
    out: 'build/application.js'
    optimize: 'uglify'

rjs.optimize config, (output) ->
    console.log output
    process.exit()