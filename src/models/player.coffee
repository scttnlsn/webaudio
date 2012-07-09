define (require) ->
    
    Backbone = require 'backbone'
    State = require 'cs!models/state'

    onStop = (player, callback) ->
        timeout = null

        player.on 'play', ->
            timeout = setTimeout callback, 1000 * player.state.remaining()

        player.on 'pause', ->
            clearTimeout timeout
            timeout = null

    class Player

        constructor: (@audio) ->
            _.extend @, Backbone.Events

            @state = new State()

            @audio.on 'load', =>
                @state.set 'duration', @audio.duration()
                @state.set 'loaded', @audio.isLoaded()

            onStop @, @stop

        start: (offset) ->
            @source = @audio.source()
            @state.reset offset
            @source.noteGrainOn 0, offset, @state.span()

        play: ->
            @start @state.time()
            @trigger 'play'

        pause: ->
            return unless @source?
            
            @source.noteOff 0
            @state.mark()
            @trigger 'pause'

        stop: =>
            @source.noteOff 0
            @source = null
            @state.clear()
            @trigger 'stop'