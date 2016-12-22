class Chord
  attr_reader :name, :sounds

  class << self
    def chord_sounds
      path = File.join(Rails.root, "lib/assets/chord_sounds.yml")
      YAML.load(File.read(path))
    end
  end

  def initialize(name:, sounds:)
    @name = name
    sounds_notation = sounds || self.class.chord_sounds[name]
    @sounds = sounds_notation.split('').map.with_index do |s, i|
      Sound.new(6 - i, s)
    end
  end

  def sounds_notation
    sounds.map(&:fret_code).join
  end

  def fret_range
    valid_frets = @sounds.select(&:valid?).map(&:fret)
    (valid_frets.min..valid_frets.max)
  end
end

Sound = Struct.new(:string, :fret_code) do
  def valid?
    fret.present?
  end

  def fret
    fret_code.match(/[\da-f]/) ? fret_code.to_i(16) : nil
  end
end
