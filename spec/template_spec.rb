require_relative '../lib/layout.rb'
require_relative '../lib/template.rb'

describe Template do

  WD = File.expand_path(File.dirname(__FILE__))
  let(:layout) { Layout.new(File.join(WD, '..', 'test', 'config.yml')) }

  describe '#initialize' do
    before(:example) do
      sample = 'AsSw'
      @template = Template.new(layout, sample)
    end

    it 'should return first symbol direction' do
      expect(@template.way[0].direction).to be nil
    end

    it 'should return first symbol shifted' do
      expect(@template.way[0].shifted?).to be true
    end

    it 'should return second symbol direction' do
      expect(@template.way[1].direction).to eq('r')
    end

    it 'should return second symbol shifted' do
      expect(@template.way[1].shifted?).to be false
    end

    it 'should return third symbol direction' do
      expect(@template.way[2].direction).to be nil
    end

    it 'should return third symbol shifted' do
      expect(@template.way[2].shifted?).to be true
    end

    it 'should return fourth symbol direction' do
      expect(@template.way[3].direction).to eq('lt')
    end

    it 'should return fourth symbol shifted' do
      expect(@template.way[3].shifted?).to be false
    end
  end

  describe '#generate_passwords' do
    it 'should generate passwords' do
      sample = '!qaZ'
      template = Template.new(layout, sample)
      expect(template.generate_passwords).
        to eq([sample, '@wsX', '#edC', '$rfV', '%tgB', '^yhN', '&ujM', '*ik<', '(ol>', ')p;?'])
    end
  end

end
