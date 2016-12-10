require 'yaml'
require_relative 'way.rb'

class Layout

	attr_reader :keys

	def initialize(config)
		@layout = YAML.load(File.read(config))
		@keys = @layout.keys
	end

	def get_way(from, to)
		from = @layout.key?(from) ? from : unshift(from)
		@layout.key?(to) ? 
			Way.new(direction: @layout[from].key(to)) : 
			Way.new(direction: @layout[from].key(unshift(to)), shifted: true)
	end

	def get_symbol(symbol, way)
		return symbol if way.direction.nil? && !way.shifted?
		return @layout[symbol]['sh'] if way.direction.nil? && way.shifted?
		symbol = @layout.key?(symbol) ? symbol : unshift(symbol)
		if !way.direction.nil? && !way.shifted?
			neighbour = get_neighbour(symbol, way.direction)
			return neighbour.empty? ? nil : neighbour
		end
		if !way.direction.nil? && way.shifted?
			neighbour = get_neighbour(symbol, way.direction)
			return neighbour.empty? ? nil : @layout[neighbour]['sh'] 
		end
	end

	private

	def get_neighbour(symbol, direction)
		@layout[symbol][direction]
	end

	def unshift(symbol)
		@layout.select{ |k, v| v['sh'] == symbol }.keys[0]
	end

end
