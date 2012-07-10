define (require) ->

    Backbone = require 'backbone'

    class WaveformView extends Backbone.View

        tagName: 'canvas'

        className: 'waveform'

        attributes:
            height: '200px'
            width: '600px'

        initialize: ({ @audio, @cursor, @scale }) ->
            @scale ||= 20

            @audio.on 'load', @render, @

        render: ->
            return @ unless @audio.isLoaded()

            @draw()
            @$el.after @cursor.position(@$el).render().el
            
            @

        draw: ->
            context = @el.getContext '2d'
            context.fillStyle = 'black'

            data = @audio.buffer.getChannelData 0

            n = Math.floor data.length / @el.width

            for x in [0...@el.width]
                start = x * n
                end = start + n

                value = @rms(start, end, data) * @el.height * @scale
                y = @el.height / 2 - value / 2

                context.fillRect x, y, 1, value

        # Helpers

        rms: (a, b, data) ->
            sum = 0.0

            for i in [a...b]
                value = data[i]
                sum += value * value

            Math.sqrt sum / data.length