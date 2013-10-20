#= require jquery
#= require jquery_ujs
#= require turbolinks

class VideoPlayer
  constructor: ->
    @iframe = $('#tbs-player')[0]
    @url = 'http://player.vimeo.com/video/64562709'
    @callbacks = {}
    window.addEventListener('message', @message.bind(this), false)

  message: (e) ->
    console.log(e.data)
    data = JSON.parse(e.data)
    if data.method == 'getCurrentTime'
      @callbacks['getCurrentTime'].apply(null, [data.value])
    if data.event == 'ready'
      @post('addEventListener', 'play', @iframe)
      @post('addEventListener', 'pause', @iframe)
    if data.event == 'pause'
      @on_pause() if @on_pause
    if data.event == 'play'
      @on_play() if @on_play

  play: ->
    @post('setVolume', 0.0001)
    @post('play')

  pause: ->
    @post('pause')

  position: (callback) ->
    @callbacks['getCurrentTime'] = callback
    @post('getCurrentTime')

  duration: ->
    @post 'getDuration'

  post: (action, value) ->
    data = {method: action}
    data.value = value if value
    url = @iframe.getAttribute('src').split('?')[0]
    @iframe.contentWindow.postMessage(JSON.stringify(data), url)

class AudioPlayer
  constructor: (track_ids) ->
    @track_ids = track_ids
    SC.initialize(client_id: 'd36389a7126d08a96d1a38498dd3e7ff')
    @streams = {}
    SC.whenStreamingReady =>
      for id in @track_ids
        @streams[id] = SC.stream('/tracks/' + id)
        @streams[id].load()

  play_track: (track_id, position) ->
    @current_stream.stop() if @current_stream
    @current_stream = @streams[track_id]
    console.log @current_stream
    @current_stream.setPosition(position)
    @current_stream.play()

  pause: ->
    @current_stream.pause() if @current_stream

@TBS =
  init: ->
    @video = new VideoPlayer()
    track_ids = []
    $('.band').each (ii, item) ->
      track_ids.push($(item).data('track-id'))
    @audio = new AudioPlayer(track_ids)
    $('.band').on 'click', @play_pause.bind(this)
    $('button#pause').on 'click', @pause.bind(this)
    @setup_video_callbacks()

  setup_video_callbacks: ->
    @video.on_pause = @pause.bind(this)
    @video.on_play = =>
      if $('.band.current')[0]
        @button = $('.band.current')
        @play()
      else
        $('.band').first().trigger 'click'

  play_pause: (ev) ->
    @button = $(ev.target)
    @button = @button.parents('.band') unless @button.hasClass('band')
    if @button.hasClass('current')
      console.log 'PAUSE'
      if @button.hasClass('paused')
        @play()
      else
        @pause()
    else
      console.log 'PLAY'
      @play()

  play: ->
    icon = @button.find('i')
    icon.removeClass('icon-play')
    icon.addClass('icon-pause')
    @video.position (position) =>
      @video.play()
      $('.band').removeClass('current')
      $('.band').removeClass('paused')
      @button.addClass('current')
      @audio.play_track(@button.data('track-id'), position * 1000)

  pause: (ev) ->
    icon = @button.find('i')
    icon.removeClass('icon-pause')
    icon.addClass('icon-play')
    @button.addClass('paused')
    @video.pause()
    @audio.pause()

$ -> TBS.init()    