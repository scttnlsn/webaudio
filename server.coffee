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
    app.use '/jam', express.static "#{__dirname}/jam"
    app.use '/app', express.static "#{__dirname}/app"
    app.use express.errorHandler({ dumpExceptions: true, showStack: true })

app.configure 'production', ->
    app.use express.errorHandler({ dumpExceptions: true })

app.locals.env = ->
    process.env.NODE_ENV

# Routes
# ---------------

app.get '/', (req, res) ->
    res.render 'index'

app.listen process.env.PORT || 3000