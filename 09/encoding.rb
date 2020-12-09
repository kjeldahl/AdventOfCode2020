input = File.readlines("input.txt").map(&:strip).map(&:to_i)

preample = 25

buffer = []
first_star = 
	input.find do |n|
		if buffer.size < preample
			buffer << n
			false
		else
			r = buffer.combination(2).none? {|c| c.sum == n}
			buffer.shift
			buffer << n
			r
		end
	end

puts "First star: #{first_star}"

fs_idx = input.index(first_star)
second_star = 
	(0..fs_idx-1).map do |start_idx|
		end_idx = (start_idx..fs_idx-1).find do |end_idx|
			input[start_idx..end_idx].sum == first_star
		end
		end_idx ? input[start_idx..end_idx].minmax.sum : nil
	end.compact.first

puts "Second star: #{second_star}"