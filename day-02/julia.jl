inBagRed = 12
inBagGreen = 13
inBagBlue = 14

function one(in)
	acc = 0

	for line in split(in, "\n")
		invalid = false

		for draw in split(split(line, ": ")[2], "; ")
			for cubes in split(draw, ", ")
				spl = split(cubes, " ")
				num = parse(Int, spl[1])
				if (spl[2] == "red" && num > inBagRed) || (spl[2] == "green" && num > inBagGreen) || (spl[2] == "blue" && num > inBagBlue)
					invalid = true
				end
			end
		end

		if !invalid
			acc += parse(Int, split(split(line, " ")[2], ":")[1])
		end
	end

	return acc
end


function two(in)
	acc = 0

	for line in split(in, "\n")
		minRed = 0
		minGreen = 0
		minBlue = 0

		for draw in split(split(line, ": ")[2], "; ")
			for cubes in split(draw, ", ")
				spl = split(cubes, " ")
				num = parse(Int, spl[1])
				if spl[2] == "red" && num > minRed
					minRed = num
				elseif spl[2] == "green" && num > minGreen
					minGreen = num
				elseif spl[2] == "blue" && num > minBlue
					minBlue = num
				end
			end
		end

		acc += minRed * minGreen * minBlue
	end

	return acc
end


using Test
@testset "works for example input" begin
	input = read("example.txt", String)
	@test one(input) == 8
	@test two(input) == 2286
end

input = read("input.txt", String)
@info "Part one: $(one(input))"
@info "Part two: $(two(input))"

