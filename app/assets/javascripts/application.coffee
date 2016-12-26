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

  $(document).on 'show.bs.tab', ".js-preview", (e) ->
    $data = $(@).data()
    $previewBody = $($data.previewBody)
    $previewBody.outerHeight($($data.previewInput).outerHeight())

    body = $($data.previewInput).val()
    url = $data.previewUrl
    params = {}
    params[$data.previewModel] = {
      body: body
    }
    $.ajax
      type: 'POST'
      url: url
      data: params
      dataType: 'text'
      success: (html) => $previewBody.html(html)
      complete: () => $(@).removeClass("disabled")

    $(@).addClass("disabled")

$(document).on 'page:load', () ->
  ChordPlayer.stop()
