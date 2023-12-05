require "log"

def one(input : String): Int64 | Nil
	split = input.split("\n\n")
	seeds = split.shift().split(" ")
	seeds.shift()
	state = seeds.map(&.to_i64)

	split.each do |m|
		lines = m.split("\n")
		op = lines.shift()
		rules = lines.map do |x|
			x.split(" ").map(&.to_i64)
		end

		state = state.map do |x|
			rule = rules.find do |r|
				x >= r[1] && x < r[1] + r[2]
			end

			if rule
				x + rule[0] - rule[1] 
			else
				x
			end
		end
	end

	state.min_by { |x| x }
end


def two(input : String) : Int64 | Nil
	split = input.split("\n\n")
	seeds = split.shift().split(" ")
	seeds.shift()
	state = Array(Range(Int64, Int64)).new

	(0..(seeds.size / 2 - 1)).each do |i|
		b = seeds[i * 2].to_i64
		e = seeds[i * 2 + 1].to_i64 + b
		state << (b..e)
	end

	Log.info { "state: #{state}" }
	split.each do |m|
		lines = m.split("\n")
		op = lines.shift()
		rules = lines.map do |x|
			x.split(" ").map(&.to_i64)
		end

		newState = Array(Range(Int64, Int64)).new

		state.each do |range|
			# rule = rules.find do |x|
			# 	(range.begin >= x[1] && range.begin < x[1] + x[2]) || (range.end >= x[1] && range.end < x[1] + x[2]) || (range.begin < x[1] && range.end > x[1] + x[2])
			# end

			# if !rule
			# 	newState << range
			# else
			# 	newState.concat(applyRule(rule, range))
			# end

			didApply = false
			rules.each do |rule|
				a = applyRule(rule, range)
				if a
					newState.concat(a)
					didApply = true
				end
			end

			if !didApply
				newState << range
			end
		end
		
		state = newState
		Log.info { "state: #{state}, op: #{op}" }
	end

	state.map { |x| x.begin }.min
end


def applyRule(rule : Array(Int64), range : Range(Int64, Int64)): Array(Range(Int64, Int64)) | Nil
	b = range.begin
	e = range.end

	if b >= rule[1] + rule[2] || e < rule[1]
		return nil
	end

	# 1. if range is completely inside rule, return fully mapped range.
	if b >= rule[1] && e <= rule[1] + rule[2]
		Log.info { "completely inside. rule: #{rule}, range: #{range}"}
		return [(b + rule[0] - rule[1])..(e + rule[0] - rule[1])]
	end

	# if range is overlapping both ends of rule, return unmapped, mapped, unmapped
	if b < rule[1] && e > rule[1] + rule[2]
		Log.info { "overlapping both ends. rule: #{rule}, range: #{range}"}
		return [(b..rule[1] - 1), (rule[0]..(rule[0] + rule[2] - 1)), (rule[1] + rule[2]..e)]
	end

	if b < rule[1] && e < rule[1] + rule[2]
		Log.info { "partially before rule: #{rule}, range: #{range}"}
		return [(b..rule[1] - 1), (rule[0]..(e + rule[0] - rule[1]))]
	end

	# 3.2 range after rule
	if b > rule[1] && e > rule[1] + rule[2]
		Log.info { "partially after, rule: #{rule}, range: #{range}"}
		return [(b - rule[1] + rule[0]..(rule[0] + rule[2] - 1)), (rule[1] + rule[2]..e)]
	end
end


