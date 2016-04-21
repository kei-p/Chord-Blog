class Entry < ActiveRecord::Base
  belongs_to :author

  validate :validate_parse_body

  def validate_parse_body
    begin
      ChordParser.new(body).parse
    rescue => e
      errors.add(:body, e.message)
    end
  end

  def author?(author)
    self.author == author
  end

  def chord_body
    @chord_body ||= begin
      ChordBody.new(body)
    end
  end
end
