class SectionDecorator < Draper::Decorator
  delegate_all


  def player
    options = {
      src: iframe_src,
      style: 'width:380px;height:170px;',
      scrolling: 'no',
      marginwidth: '0',
      marginheight: '0',
      frameborder: '0'
    }
    h.content_tag(:iframe, nil, options)
  end

  private

  def iframe_base_url
  "http://www.rittor-music.co.jp/app/shibanzukun/bloguitar/bloguitar.html"
  end

  def iframe_style
    "b=4&c=0xFFFFFF&m=d&x=b&s=1&p=on&v=25"
  end

  def iframe_sounds
    flatten_chords.map.with_index do |c, i|
      num = i+1
      "n#{num}=#{CGI.escape(c.name)}&f#{num}=#{c.sounds.reverse}"
    end.join('&')
  end

  def iframe_src
    "#{iframe_base_url}?#{iframe_style}&#{iframe_sounds}"
  end
end
