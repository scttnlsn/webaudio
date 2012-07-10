define (require) ->

    Backbone = require 'backbone'

    class CursorView extends Backbone.View

        className: 'cursor'

        initialize: ({ @state, @timer }) ->
            @timer.on 'tick', @render, @

        position: (@container) ->
            @

        render: ->
            return @ unless @container?

            height = @container.height()
            @$el.css 'top', "-#{height}px"

            bar = @make 'div', { class: 'bar' }, null
            $(bar).css
                height: "#{height}px"
                left: @state.percentage() * @container.width()

            @$el.html bar
            @