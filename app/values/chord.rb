class Chord
  attr_reader :name, :sounds

  class << self
    def chord_sounds
      path = File.join(Rails.root, "lib/assets/chord_sounds.yml")
      YAML.load(File.read(path))
    end
  end

  def initialize(name)
    @name = name
    @sounds = self.class.chord_sounds[@name]
  end
end
