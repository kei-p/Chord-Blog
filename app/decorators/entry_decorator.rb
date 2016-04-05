class EntryDecorator < Draper::Decorator
  delegate_all

  def decorated_chord_body
    @decorated_chord_body ||= ChordBodyDecorator.new(chord_body)
  end
end
