class ChordParser
  attr_reader :text

  def initialize(text)
    @text = text
  end

  def parse
    result = []
    block = nil
    text.scan(/[\w:()# |]+/).map(&:strip).each do |word|
      if match = word.match(/([ \w]+):/)
        block = {
          name: match[1],
          chords: []
        }
        result << block
      elsif block
        block[:chords] += word.split('|').map(&:strip)
      end
    end
    result
  end
end
