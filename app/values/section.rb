class Section
  attr_reader :title, :measures

  def initialize(title)
    @title = title
    @measures = []
  end

  def add_measure(measure)
    @measures << measure
  end
end
