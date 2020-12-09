input = File.read("input.txt").strip

groups = input.split(/^$/)

first_star = 
	groups.sum do |group|
		answers = group.gsub(/\n/,"")
		answers.chars.uniq.size
	end

puts "First star: #{first_star}"

second_star = 
	groups.sum do |group|
		answers = group.split(/\n/).reject(&:empty?)
		all_answers = group.gsub(/\n/,"").chars.uniq
		all_answers.count {|aa| answers.all?{|a| a.include?(aa)}}
	end

puts "Second star: #{second_star}"
