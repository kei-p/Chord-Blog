class ChordBody
  attr_reader :sections, :body

  def initialize(body)
    @body = body
    map
  end

  private

  def map
    @sections = begin
      ChordParser.new(body).parse.map do |s|
        section = Section.new(s[:title])

        s[:measures].each do |m|
          measure = m.map { |c| Chord.new(c) }
          section.add_measure(measure)
        end

        section
      end
    rescue
      []
    end
  end
end
