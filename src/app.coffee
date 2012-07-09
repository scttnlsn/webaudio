define (require) ->

    $ = require 'jquery'
    
    Audio = require 'cs!models/audio'
    Player = require 'cs!models/player'
    Timer = require 'cs!models/timer'
    CursorView = require 'cs!views/cursor_view'
    PlayerView = require 'cs!views/player_view'
    TimerView = require 'cs!views/timer_view'
    WaveformView = require 'cs!views/waveform_view'

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