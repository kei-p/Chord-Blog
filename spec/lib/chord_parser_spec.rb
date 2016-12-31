require 'rails_helper'

describe ChordParser do
  let(:parser) { ChordParser.new(text) }
  let(:text) do
    <<-"EOS"
    Intro:
    GbM7(9) | F7(#9) | Bbm7(9) | Db9

    A melody:
    Bbm7(11) | Bbm7(11) | Bm7(11) | Bm7(11)
    EOS
  end

  describe '#parse' do
    subject { parser.parse }

    context 'line style' do
      let(:org_text) do
        <<-"EOS"
        Intro:
        GbM7(9) | F7(#9) | Bbm7(9) | Db9

        A melody:
        Bbm7(11) | Bbm7(11) | Bm7(11) | Bm7(11)
        EOS
      end

      context 'simple' do
        let(:text) { org_text }
        it do
          expect(subject[0][:title]).to eq('Intro')
          expect(subject[0][:measures][0][0][:name]).to eq('GbM7(9)')
          expect(subject[0][:measures][0][0][:sounds]).to eq(nil)
          expect(subject[1][:title]).to eq('A melody')
        end
      end

      context 'break line \r' do
        let(:text) { org_text.gsub(/\n/, "\r") }

        it do
          expect(subject[0][:title]).to eq('Intro')
          expect(subject[0][:measures][0][0][:name]).to eq('GbM7(9)')
          expect(subject[0][:measures][0][0][:sounds]).to eq(nil)
          expect(subject[1][:title]).to eq('A melody')
        end
      end

      context 'break line \r\n' do
        let(:text) { org_text.gsub(/\n/, "\r\n") }

        it do
          expect(subject[0][:title]).to eq('Intro')
          expect(subject[0][:measures][0][0][:name]).to eq('GbM7(9)')
          expect(subject[0][:measures][0][0][:sounds]).to eq(nil)
          expect(subject[1][:title]).to eq('A melody')
        end
      end
    end

    context 'with sounds' do
      let(:text) do
        <<-"EOS"
        Intro:
        GbM7(9){3n3324} | F7(#9){1n2212}
        EOS
      end

      it do
        expect(subject[0][:measures][0][0][:name]).to eq('GbM7(9)')
        expect(subject[0][:measures][0][0][:sounds]).to eq('3n3324')

        expect(subject[0][:measures][1][0][:name]).to eq('F7(#9)')
        expect(subject[0][:measures][1][0][:sounds]).to eq('1n2212')
      end
    end

    context 'on Chord' do
      let(:text) do
        <<-"EOS"
        Intro:
        AonB{7n765n} | F7(#9){1n2212}
        EOS
      end

      it do
        expect(subject[0][:title]).to eq('Intro')
        expect(subject[0][:measures][0][0][:name]).to eq('AonB')
        expect(subject[0][:measures][0][0][:sounds]).to eq('7n765n')

        expect(subject[0][:measures][1][0][:name]).to eq('F7(#9)')
        expect(subject[0][:measures][1][0][:sounds]).to eq('1n2212')
      end
    end
  end
end
