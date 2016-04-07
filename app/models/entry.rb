class Entry < ActiveRecord::Base
  belongs_to :author

  def author?(author)
    self.author == author
  end

  def chord_body
    @chord_body ||= begin
      ChordBody.new(body)
    end
  end
end
