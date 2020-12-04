input = File.readlines("input.txt").map(&:strip)

policy_and_passwords = input.map { |l| l.split(/(\d+)-(\d+) (\w): (\w+)/).tap(&:shift)}

first_star = policy_and_passwords.count do |n,m,l,pwd|
	((n.to_i)..(m.to_i)).include?(pwd.chars.count {|c| c == l})
end

puts "First star: #{first_star}"

second_star = policy_and_passwords.count do |n,m,l,pwd|
	[pwd[n.to_i - 1], pwd[m.to_i - 1]].count {|c| c == l} == 1
end

puts "Second star: #{second_star}"
