input = File.readlines("input.txt").map(&:strip).map(&:to_i)

puts "First star: #{input.combination(2).find { |a,b| a+b == 2020 }.reduce(:*)}"

puts "Second star: #{input.combination(3).find { |a| a.sum == 2020 }.reduce(:*)}"