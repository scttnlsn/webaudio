define (require) ->

    $ = require 'jquery'
    
    Audio = require 'cs!app/models/audio'
    Player = require 'cs!app/models/player'
    Timer = require 'cs!app/models/timer'
    CursorView = require 'cs!app/views/cursor_view'
    PlayerView = require 'cs!app/views/player_view'
    TimerView = require 'cs!app/views/timer_view'
    WaveformView = require 'cs!app/views/waveform_view'

    audio = new Audio '/example.mp3'
    player = new Player audio
    timer = new Timer player, 24

    cursorView = new CursorView { state: player.state, timer }
    timerView = new TimerView { state: player.state, timer }
    playerView = new PlayerView { player }
    waveformView = new WaveformView { audio, cursor: cursorView }

    app = {}

    app.start = ->
        audio.load()

        $ ->
            $('#timer').html timerView.render().el
            $('#player').html playerView.render().el
            $('#waveform').html waveformView.render().el

    app