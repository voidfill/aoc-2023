inBagRed = 12
inBagGreen = 13
inBagBlue = 14

function oneAlt(input)
	isReading = false
	num = ""
	readingNum = false

	gameId = -1
	curInvalid = false

	nextNum = false

	acc = 0

	for i in eachindex(input)
		c = input[i]

		if nextNum && c == ' '
			nextNum = false
			continue
		end

		if !isReading
			if c == ':'
				if gameId == -1
					gameId += 1
					continue
				end

				isReading = true
				gameId += 1
				if !curInvalid && gameId > 0
					curInvalid = false
					acc += gameId
				end

				if curInvalid
					curInvalid = false
				end
			end
		else
			if c == '\n'
				isReading = false
				continue
			end
			if readingNum && c == ' '
				readingNum = false
				continue
			end

			if c >= '0' && c <= '9'
				readingNum = true
				num *= c
				continue
			end

			if !nextNum && (c == 'r' || c == 'g' || c == 'b')
				nextNum = true
				intN = parse(Int, num)
				num = ""
				if (c == 'r' && intN > inBagRed) || (c == 'g' && intN > inBagGreen) || (c == 'b' && intN > inBagBlue)
					curInvalid = true
					isReading = false
				end
			end
		end
	end

	if !curInvalid && gameId > 0
		gameId += 1
		curInvalid = false
		acc += gameId
	end

	return acc
end

function two(input)

end


using Test
@testset "works for example input" begin
	input = read("example.txt", String)
	@test oneAlt(input) == 8
	# @test two(input) == 2286
end

input = read("input.txt", String)
@info "Part one: $(oneAlt(input))"
@info "Part two: $(two(input))"
