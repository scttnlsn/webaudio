define (require) ->

    Backbone = require 'backbone'

    class Timer

        constructor: (player, @fps) ->
            _.extend @, Backbone.Events

            player.on 'play', @start, @
            player.on 'pause', @stop, @

            unless player.state.isPaused()
                @start()

        tick: =>
            @trigger 'tick'

        start: ->
            @ticking = setInterval @tick, 1000 / @fps

        stop: ->
            clearInterval @ticking
            @ticking = null

        isRunning: ->
            @ticking?