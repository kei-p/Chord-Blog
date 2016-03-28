require 'rails_helper'

describe ChordParser do
  let(:parser) { ChordParser.new(text) }
  let(:text) { FactoryGirl.attributes_for(:entry)[:body] }

  describe '#parse' do
    subject { parser.parse }
    it do
      expect(subject).to eq([
        {
          name: 'Intro',
          chords: %w{GbM7(9) F7(#9) Bbm7(9) AonB}
        },
        {
          name: 'A melody',
          chords: %w{Bbm7(11) Bbm7(11) Bm7(11) Bm7(11)}
        },
      ])
    end
  end
end
