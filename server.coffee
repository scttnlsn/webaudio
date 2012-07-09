express = require 'express'

app = express()

# Config
# ---------------

app.configure ->
    app.set 'view engine', 'jade'
    app.set 'views', __dirname
    app.set 'scripts', []

    app.use app.router
    app.use express.static "#{__dirname}/public"

app.configure 'development', ->
    app.set 'scripts', [{ 'src': '/src/vendor/require.js', 'data-main': '/src/main' }]

    app.use '/src', express.static "#{__dirname}/src"
    app.use express.errorHandler({ dumpExceptions: true, showStack: true })

app.configure 'production', ->
    app.set 'scripts', [
        { src: 'http://cdnjs.cloudflare.com/ajax/libs/require.js/2.0.2/require.min.js' },
        { src: 'https://s3.amazonaws.com/webaudio.herokuapp.com/application.js' },
    ]

    app.use express.errorHandler({ dumpExceptions: true })

app.locals.js = ->
    tags = for script in app.set 'scripts'
        attrs = ("#{key}=\"#{val}\"" for key, val of script).join ' '
        "<script #{attrs}></script>"

    tags.join '\n'

# Routes
# ---------------

app.get '/', (req, res) ->
    res.render 'index'

app.listen process.env.PORT || 3000