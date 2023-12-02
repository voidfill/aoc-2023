function one(in)
	acc = 0;

	for line in split(in, "\n")
		filtered = filter(x -> x >= '0' && x <= '9', collect(line))
		if length(filtered) != 0
			acc += parse(Int, join([filtered[1], last(filtered)]))
		end
	end

	return acc
end

function two(in)
	in = replace(in, "one" => "one1one")
	in = replace(in, "two" => "two2two")
	in = replace(in, "three" => "three3three")
	in = replace(in, "four" => "four4four")
	in = replace(in, "five" => "five5five")
	in = replace(in, "six" => "six6six")
	in = replace(in, "seven" => "seven7seven")
	in = replace(in, "eight" => "eight8eight")
	in = replace(in, "nine" => "nine9nine")

	return one(in)
end


using Test
@testset "works for example input" begin
	@test one(read("example1.txt", String)) == 142
	@test two(read("example2.txt", String)) == 281
end

input = read("input.txt", String)
@info "Part one: $(one(input))"
@info "Part two: $(two(input))"
