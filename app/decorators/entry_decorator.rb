class EntryDecorator < Draper::Decorator
  delegate_all

  def created_date
    created_at.strftime("%Y/%m/%d")
  end

  def decorated_chord_body
    @decorated_chord_body ||= ChordBodyDecorator.new(chord_body)
  end
end
