require_relative 'way.rb'

class Template

  attr_reader :way

  def initialize(layout, sample)
    @layout = layout
    @way = [@layout.get_way(sample[0], sample[0])]
    sample.each_char.with_index do |symbol, index|
      if index < sample.length - 1
        @way << @layout.get_way(symbol, sample[index + 1])
      end
    end
  end

  def generate_passwords
    passwords = Array.new
    @layout.keys.each do |symbol|
      password = generate_password(symbol)
      passwords << password if password.length == @way.length
    end
    return passwords
  end

  private

  def generate_password(symbol)
    password = String.new
    @way.each do |way|
      break if symbol.nil?
      symbol = @layout.get_symbol(symbol, way)
      password << symbol.to_s
    end
    return password
  end

end
