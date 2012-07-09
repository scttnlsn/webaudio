define (require) ->

    Backbone = require 'backbone'

    class Audio

        constructor: (@url, @context) ->
            _.extend @, Backbone.Events

            @context ||= new webkitAudioContext()

        isLoaded: ->
            @buffer?

        duration: ->
            if @buffer? then @buffer.duration else 0

        source: ->
            source = @context.createBufferSource()
            source.buffer = @buffer
            source.connect @context.destination
            source

        load: ->
            deferred = $.Deferred()

            req = new XMLHttpRequest()
            req.open 'get', @url, true
            req.responseType = 'arraybuffer'

            req.onload = =>
                success = (buffer) =>
                    @buffer = buffer
                    @trigger 'load'
                    deferred.resolve()

                error = ->
                    deferred.reject()

                @context.decodeAudioData req.response, success, error

            req.send()
            deferred.promise()