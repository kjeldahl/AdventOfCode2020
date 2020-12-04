input = File.read("input.txt")

# Ignore missing cid field

passports = input.split(/^$/).
				map {|l| l.gsub(/\n/, " ")}.
				map {|l| l.split(" ").map {|ll| ll.split(":")}.to_h}

def valid?(fields)
	expected_keys = %w[byr iyr eyr hgt hcl ecl pid].freeze
	expected_keys.all? {|e| fields.include?(e) }
end

first_star = passports.count do |fields, values|
	valid?(fields)
end
puts "First star: #{first_star}"

def valid_password?(password)
	return false unless valid?(password.keys)
	password.all? do |field, value|
		case field
		when "byr" 
			(1920..2002).cover?(value.to_i)
		when "iyr" 
			(2010..2020).cover?(value.to_i)
		when "eyr" 
			(2020..2030).cover?(value.to_i)
		when "hgt" 
			(value =~ /\A(\d+)(cm|in)\z/) && (($2 == "cm" ? (150..193):(59..76)).cover?($1.to_i))
		when "ecl" 
			value =~ /\Aamb|blu|brn|gry|grn|hzl|oth\z/
		when "hcl" 
			value =~ /\A#[0-9a-f]{6}\z/
		when "pid" 
			value =~ /\A\d{9}\z/
		when "cid"
			true
		else 
			raise "Unknown field: '#{field}'"
		end
	end
end

second_star = passports.count {|p| valid_password?(p) }
puts "Second star: #{second_star}"