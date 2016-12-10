require_relative '../lib/way.rb'

describe Way do

  describe '#initialize' do
    it 'should set direction according to sended value' do
      way = Way.new(direction: 'rt')
      expect(way.direction).to eq('rt')
    end

    it 'should set direction to nil by default' do
      way = Way.new
      expect(way.direction).to be nil
    end
  end

  describe '#shifted?' do
    it 'should response with true if it was sended' do
      way = Way.new(shifted: true)
      expect(way.shifted?).to be true
    end

    it 'should response with false by default' do
      way = Way.new
      expect(way.shifted?).to be false
    end
  end

end
