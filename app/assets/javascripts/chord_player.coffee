SOUND_NAMES = [
  '/media/1st_String_E.mp3',
  '/media/2nd_String_B.mp3',
  '/media/3rd_String_G.mp3',
  '/media/4th_String_D.mp3',
  '/media/5th_String_A.mp3',
  '/media/6th_String_E.mp3'
]

class ChordPlayer
  constructor: ->
    @ctx = new AudioContext()
    @gainNode = @ctx.createGain()
    @buffer = {}
    @sounds = []
    @gainNode.gain.value = 0.3

  load: ->
    window.AudioContext = window.AudioContext || window.webkitAudioContext

    $.each SOUND_NAMES, (i, sound) =>
      xml = new XMLHttpRequest();
      xml.responseType = 'arraybuffer'
      xml.open('GET', sound, true)
      xml.onload = () =>
        @.ctx.decodeAudioData(xml.response).then (data) =>
          @.buffer[sound] = data
      xml.send()

  _rate: (fret) ->
    Math.pow(2, fret/12)

  _play: (string=6, fret=0) ->
    sound = @ctx.createBufferSource()
    sound.buffer = @buffer[SOUND_NAMES[string-1]]
    sound.playbackRate.value = @._rate(fret)
    sound.connect(@gainNode)
    @gainNode.connect(@ctx.destination)
    sound.start(0)
    @sounds.push(sound)

  play: (chord, interval = 0) ->
    duration = 0
    while @sounds.length
      v = @sounds.pop()
      v.stop()

    $.each chord.toString().split('').slice(0, 6), (i, v) =>
      fret = parseInt(v, 16)
      unless isNaN(fret)
        string = 6 - i
        setTimeout () =>
            @._play(string, fret)
          , duration
        duration += interval

window.ChordPlayer = new ChordPlayer()
