require "log"

def one(input : String): Int32 | Nil
	splInput = input.split("\n\n")

	rl = splInput[0].split("").map { |c| c == "R" ? 1 : 0 }

	mappings = Hash(String, Tuple(String, String)).new

	splInput[1].split("\n").each do |line|
		mappings[line[0..2]] = {line[7..9], line[12..14]}
	end

	cur = "AAA"
	acc = 0

	while cur != "ZZZ"
		dir = rl[acc % rl.size]
		acc += 1

		cur = mappings[cur][dir]
	end

	acc
end


def two(input : String) : Int64 | Nil
	splInput = input.split("\n\n")

	rl = splInput[0].split("").map { |c| c == "R" ? 1 : 0 }

	mappings = Hash(String, Tuple(String, String)).new

	splInput[1].split("\n").each do |line|
		mappings[line[0..2]] = {line[7..9], line[12..14]}
	end

	acc = 0.to_i64

	paths = mappings.keys.reject! { |k| k[2] != 'A' }
	seenAt = Array(Hash(String, Int64)).new(paths.size) { |k| Hash(String, Int64).new }

	loops = Array(Int64).new(paths.size, 0)

	while ! loops.all? { |l| l != 0 }
		dir = rl[acc % rl.size]
		acc += 1

		paths.map! { |p| mappings[p][dir] }

		(0..paths.size - 1).each do |i|
			if paths[i][2] != 'Z'
				next
			end

			if seenAt[i].has_key?(paths[i])
				if loops[i] == 0
					loops[i] = acc - seenAt[i][paths[i]]
				end
			else
				seenAt[i][paths[i]] = acc
			end
		end
	end

	s = loops.sort!()
	p = loops.pop()

	res = 0.to_i64

	
	r = true
	while r
		r = false
		res += p

		loops.each do |l|
			if res % l != 0
				r = true
				break
			end
		end
	end


	res
end
