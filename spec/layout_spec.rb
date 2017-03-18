require_relative '../lib/layout.rb'

describe Layout do

  let(:layout) { Layout.new(File.join(File.expand_path(File.dirname(__FILE__)), '..', 'test', 'config.yml')) }

  describe '#get_way' do
    it 'should return direction for neighbours which are presented without shifting' do
      expect(layout.get_way('1', '2').direction).to eq('r')
    end

    it 'should return shifted state for neighbours which are presented without shifting' do
      expect(layout.get_way('1', '2').shifted?).to be false
    end

    it 'should return direction for neighbours with first shifted' do
      expect(layout.get_way('!', '2').direction).to eq('r')
    end

    it 'should return shifted state for neighbours with first shifted' do
      expect(layout.get_way('!', '2').shifted?).to be false
    end

    it 'should return direction for both shifted' do
      expect(layout.get_way('!', '@').direction).to eq('r')
    end

    it 'should return shifted state' do
      expect(layout.get_way('!', '@').shifted?).to be true
    end

    it 'should return direction for symbol itself' do
      expect(layout.get_way('1', '1').direction).to be nil
    end

    it 'should return shifted state for symbol itself' do
      expect(layout.get_way('1', '1').shifted?).to be false
    end

    it 'should return direction for symbol itself with first shifted' do
      expect(layout.get_way('!', '1').direction).to be nil
    end

    it 'should return shifted state for symbol itself with first shifted' do
      expect(layout.get_way('!', '1').shifted?).to be false
    end

    it 'should return direction for symbol itself with both shifted' do
      expect(layout.get_way('!', '!').direction).to be nil
    end

    it 'should return shifted state for symbol itself with both shifted' do
      expect(layout.get_way('!', '!').shifted?).to be true
    end

    it 'should return shortest path between non-neighbours' do
      expect(layout.get_way('3', 'q').direction).to eq('ld;l')
    end

    it 'should return shortest path between non-neighbours with second shifted' do
      expect(layout.get_way('z', '@').direction).to eq('lt;lt;rt')
    end
  end

  describe '#get_symbol' do
    it 'should return symbol itself' do
      expect(layout.get_symbol('1', Way.new)).to eq('1')
    end

    it 'should return shifted itself' do
      expect(layout.get_symbol('1', Way.new(shifted: true))).to eq('!')
    end

    it 'should return unshifted itself' do
      expect(layout.get_symbol('!', Way.new(shifted: false))).to eq('1')
    end

    it 'should return not-shifted neighbour' do
      expect(layout.get_symbol('1', Way.new(direction: 'rd'))).to eq('q')
    end

    it 'should return shifted neighbour' do
      expect(layout.get_symbol('1', Way.new(direction: 'rd', shifted: true))).to eq('Q')
    end

    it 'should return nil for non-existent neighbour' do
      expect(layout.get_symbol('`', Way.new(direction: 'rd', shifted: true))).to be nil
    end

    it 'should return non-shifted neighbour for shifted symbol' do
      expect(layout.get_symbol('!', Way.new(direction: 'rd'))).to eq('q')
    end

    it 'should return shifted neighbour for shifted symbol' do
      expect(layout.get_symbol('!', Way.new(direction: 'rd', shifted: true))).to eq('Q')
    end

    it 'should return non-neighbour' do
      expect(layout.get_symbol('1', Way.new(direction: 'r;rd;rd'))).to eq('s')
    end
  end
end
