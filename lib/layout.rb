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
		shifted = false
		if !@layout.key?(to)
			to = unshift(to)
			shifted = true
		end
		return Way.new(direction: nil, shifted: shifted) if from == to
		queue, pathes = Array.new, Hash.new
		queue.push(from)
		while !queue.empty? do
			symbol = queue.shift
			return Way.new(direction: pathes[symbol], shifted: shifted) if symbol == to
			get_neighbours(symbol).each do |neighbour, direction|
				if !pathes.keys.include?(neighbour)
					queue.push(neighbour)
					pathes[neighbour] = pathes[symbol].nil? ? direction : [pathes[symbol], direction].join(';')
				end
			end
		end
	end

	def get_symbol(symbol, way)
		symbol = @layout.key?(symbol) ? symbol : unshift(symbol)
		return symbol if way.direction.nil? && !way.shifted?
		return @layout[symbol]['sh'] if way.direction.nil? && way.shifted?
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
		direction.split(';').each do |direction|
			symbol = @layout[symbol][direction] if !symbol.empty?
		end
		return symbol
	end

	def get_neighbours(symbol)
		neighbours = Hash.new
		@layout[symbol].each do |direction, neighbour|
			neighbours[neighbour] = direction if !neighbour.empty? && direction != 'sh'
		end
		return neighbours
	end

	def unshift(symbol)
		@layout.select{ |k, v| v['sh'] == symbol }.keys[0]
	end

end
