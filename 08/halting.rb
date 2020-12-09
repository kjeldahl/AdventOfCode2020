input = File.readlines("input.txt").map(&:strip)

instrs = input.map {|l| l.split(/(nop|acc|jmp) ([+-]\d+)/).tap(&:shift)}

def evaluate(instrs)
	executed = []
	ip = 0
	acc = 0
	looping = false
	exiting = false
	
	while !looping && !exiting
		executed << ip
		instr, offset = *instrs[ip]

		case instr
		when "acc"
			acc += offset.to_i
			ip += 1
		when "jmp"
			ip += offset.to_i
		when "nop"
			ip += 1
		else
			raise "Unknown instruction #{instr}"
		end

		looping = executed.include?(ip)
		exiting = ip >= instrs.size
	end

	{acc: acc, looping: looping}
end

r = evaluate(instrs)
puts "First star: #{r[:acc]}"

second_star = 
	instrs.map do |is|
		case is.first
		when "nop"
			is[0] = "jmp"
			evaluate(instrs).tap { is[0] = "nop" }
		when "jmp"
			is[0] = "nop"
			evaluate(instrs).tap { is[0] = "jmp" }
		else
			{acc: -1, looping: true}
		end
	end.find {|r| !r[:looping]}[:acc]

puts "Second star: #{second_star}"