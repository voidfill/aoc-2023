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

	state.min
end


def two(input : String) : Int64 | Nil
	split = input.split("\n\n")
	seeds = split.shift().split(" ")
	seeds.shift()
	unmapped = Array(Range(Int64, Int64)).new

	(0..(seeds.size / 2 - 1)).each do |i|
		b = seeds[i * 2].to_i64
		e = seeds[i * 2 + 1].to_i64 + b
		unmapped << (b..e)
	end

	split.each do |m|
		lines = m.split("\n")
		op = lines.shift()
		rules = lines.map do |x|
			x.split(" ").map(&.to_i64)
		end

		mapped = Array(Range(Int64, Int64)).new
		leftovers = Array(Range(Int64, Int64)).new

		rules.each do |rule|
			while unmapped.size > 0
				r = unmapped.pop()

				if r.begin >= rule[1] + rule[2] || r.end < rule[1]
					leftovers << r
					next
				end

				if r.begin >= rule[1] && r.begin < rule[1] + rule[2] && r.end < rule[1] + rule[2]
					mapped << (r.begin + rule[0] - rule[1]..r.end + rule[0] - rule[1])
					next
				end

				if r.begin < rule[1] && r.end >= rule[1] + rule[2]
					mapped << (rule[0]..rule[0] + rule[2])
					leftovers << (r.begin..rule[1] - 1)
					leftovers << (rule[1] + rule[2]..r.end)
					next
				end

				if r.begin < rule[1] && r.end >= rule[1] && r.end < rule[1] + rule[2]
					mapped << (rule[0]..r.end + rule[0] - rule[1])
					leftovers << (r.begin..rule[1] - 1)
					next
				end

				if r.begin >= rule[1] && r.begin < rule[1] + rule[2] && r.end >= rule[1] + rule[2]
					mapped << (r.begin + rule[0] - rule[1]..rule[0] + rule[2])
					leftovers << (rule[1] + rule[2]..r.end)
					next
				end
			end
			unmapped = leftovers
			leftovers = Array(Range(Int64, Int64)).new
		end

		unmapped.concat(mapped)
	end

	unmapped.min_by(&.begin).begin
end
