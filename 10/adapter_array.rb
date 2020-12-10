input = File.readlines("input.txt").map(&:strip).map(&:to_i).sort

input = [0] + input + [input.max+3]

one_jolt   = input.each_cons(2).count{|n1,n2| n2-n1 == 1}
three_jolt = input.each_cons(2).count{|n1,n2| n2-n1 == 3}

puts "First star: #{one_jolt * three_jolt}"

second_star =
	input.each_cons(2).map{|n1,n2| n2 - n1}.
	      each_cons(3).map do |n1,n2,n3|
		case n1
		when 1
			s = 0
			if n2 == 1
				s += 1 # 1 -> 1   = 1
				s += 2 if n3 == 1 # 1 -> 1 -> 1  = 2
			end
			s
		when 3
			0
		else
			raise "Invalid diff #{n1}"
		end
	end.chunk_while{|n| !n.zero?}.map(&:sum).reject(&:zero?).map{|i|[2,i].max}.reduce(:*)

puts "Second star: #{second_star}"

=begin
(0) 1 2 3 (6)
   1 1 1 3 

2 + 2 + 1

(0) 1 4 5 6 7 10 11 12 15 16 19 (22)
   1 3 1 1 1 3  1  1  3  1  3  3

    0 0 3 1 0  0  1  0  0  0  0 
     0   4    0   1       0
         4        2 (min 2)
              8

1 -> 1   = 1
1 -> 3   = 0
1 -> 1 1 = 2   
3 -> 1   = 0
3 -> 3   = 0
=end