#= require jquery
#= require jquery_ujs
#= require tether
#= require turbolinks
#= require bootstrap-sprockets
#= require_tree .

$ ->
  ChordPlayer.load()

  $(document).on 'click', '.js-play-chord', () ->
    sounds = $(@).data().chordSounds
    ChordPlayer.play(sounds, 50)
    return false
