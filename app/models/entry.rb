class Entry < ActiveRecord::Base
  belongs_to :user

  validate :validate_parse_body

  def validate_parse_body
    begin
      ChordParser.new(body).parse
    rescue => e
      errors.add(:body, e.message)
    end
  end

  def user?(users)
    self.user == user
  end

  def chord_body
    @chord_body ||= begin
      ChordBody.new(body)
    end
  end
end
