require 'rails_helper'

describe ChordParser do
  let(:parser) { ChordParser.new(text) }
  let(:text) { FactoryGirl.attributes_for(:entry)[:body] }

  describe '#parse' do
    subject { parser.parse }

    context 'simple' do
      let(:text) { FactoryGirl.attributes_for(:entry)[:body] }
      it do
        expect(subject[0][:title]).to eq('Intro')
        expect(subject[0][:measures][0][0][:name]).to eq('GbM7(9)')
        expect(subject[0][:measures][0][0][:sounds]).to eq(nil)
        expect(subject[1][:title]).to eq('A melody')
      end
    end

    context 'break line \r' do
      let(:text) { FactoryGirl.attributes_for(:entry)[:body].gsub(/\n/, "\r") }
      it do
        expect(subject[0][:title]).to eq('Intro')
        expect(subject[0][:measures][0][0][:name]).to eq('GbM7(9)')
        expect(subject[0][:measures][0][0][:sounds]).to eq(nil)
        expect(subject[1][:title]).to eq('A melody')
      end
    end

    context 'break line \r\n' do
      let(:text) { FactoryGirl.attributes_for(:entry)[:body].gsub(/\n/, "\r\n") }
      it do
        expect(subject[0][:title]).to eq('Intro')
        expect(subject[0][:measures][0][0][:name]).to eq('GbM7(9)')
        expect(subject[0][:measures][0][0][:sounds]).to eq(nil)
        expect(subject[1][:title]).to eq('A melody')
      end
    end

    context 'with sounds' do
      let(:text) { FactoryGirl.attributes_for(:entry, :with_sounds)[:body] }
      it do
        p text
        p subject
        expect(subject[0][:title]).to eq('Intro')
        expect(subject[0][:measures][0][0][:name]).to eq('GbM7(9)')
        expect(subject[0][:measures][0][0][:sounds]).to eq('3n3324')
        expect(subject[1][:title]).to eq('A melody')
      end
    end
  end
end
