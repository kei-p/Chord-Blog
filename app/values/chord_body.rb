class ChordBody
  attr_reader :sections, :body, :errors

  def initialize(body)
    @body = body
    @errors = []
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
    rescue => e
      errors.push e
      []
    end
  end
end
