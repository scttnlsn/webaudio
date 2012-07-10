define (require) ->

    Backbone = require 'backbone'
    
    class TimerView extends Backbone.View

        initialize: ({ @state, @timer }) ->
            @state.on 'change', @render, @
            @timer.on 'tick', @render, @

        render: ->
            if @state.get 'loaded'
                time = @state.time().toFixed(2)
                duration = @state.get('duration').toFixed(2)
                display = "#{time} / #{duration}"

            @$el.html display
            @