input = File.readlines("input.txt").map(&:strip).map(&:chars)

def trees(input, slope)
	width = input.first.size
	height = input.size
	x,y = slope.map{|i| i*-1}
	input.count do |l|
		if (y>= height - slope[1])
			false
		else
			x += slope[0]
			y += slope[1]
			input[y][x % width] == "#"
		end
	end
end

first_star = trees(input, [3,1])
puts "First star: #{first_star}"

slopes = [[1,1],[3,1],[5,1],[7,1],[1,2]]
second_star = slopes.map{|s| trees(input, s)}.reduce(:*)
puts "Second star: #{second_star}"