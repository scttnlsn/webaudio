define (require) ->

    Backbone = require 'backbone'
    
    class State extends Backbone.Model

        defaults:
            paused: 0
            duration: 0
            loaded: false

        initialize: ->


        reset: (offset) ->
            @set { offset, paused: null, started: Date.now() }

        clear: ->
            @set { paused: 0, offset: null, started: null }

        span: ->
            @get('duration') - @get('offset')

        mark: ->
            @set 'paused', @time()

        time: ->
            paused = @get 'paused'
            return paused if paused?

            started = @get 'started'
            return 0 unless started?

            delta = Date.now() - started
            time = delta / 1000 + @get('offset')
            Math.min time, @get('duration')

        remaining: ->
            @get('duration') - @time()

        percentage: ->
            @time() / @get('duration')

        isPaused: ->
            @get('paused')?