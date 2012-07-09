define (require) ->

    Backbone = require 'backbone'
    
    class PlayerView extends Backbone.View

        events:
            'click .toggle': 'toggle'

        initialize: ({ @player }) ->
            @template = require 'hbs!templates/player'

            @player.audio.on 'load', @render, @
            @player.state.on 'change', @render, @

        render: ->
            @$el.html @template
                loaded: @player.audio.isLoaded()
                paused: @player.state.isPaused()

            @

        # Event Handlers

        toggle: ->
            if @player.state.isPaused()
                @player.play()
            else
                @player.pause()