input = File.readlines("input.txt").map(&:strip)

def seat_id(row, column)
	row * 8 + column
end

def calc_row(b)
	b.chars.reverse.each_with_index.sum {|c, index| c=="B" ? 1 << index : 0 }
	Integer(b.tr("BF","10"),2)
end

def calc_column(b)
	b.chars.reverse.each_with_index.sum {|c, index| c=="R" ? 1 << index : 0 }
	Integer(b.tr("RL", "10"),2)
end

def board(b)
	row = calc_row(b[0..6])
	column = calc_column(b[7..9])
	seat = seat_id(row, column)
	puts "#{b}: Row: #{row} Col: #{column} seat id: #{seat}"
end

first_star = 
	input.map do |boarding|
		row = calc_row(boarding[0..6])
		column = calc_column(boarding[7..9])
		seat_id(row, column)
	end.max

puts "First star: #{first_star}"

second_star = 
	input.map do |boarding|
		row = calc_row(boarding[0..6])
		column = calc_column(boarding[7..9])
		seat_id(row, column)
	end.sort.each_cons(2).find {|a,b| b == a+2}.first + 1

puts "Second star: #{second_star}"
