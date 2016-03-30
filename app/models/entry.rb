class Entry < ActiveRecord::Base
  belongs_to :author

  def author?(author)
    self.author == author
  end
end
