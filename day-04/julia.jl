function one(input)
	startCard = 1
	while(input[startCard] != ':')
		startCard += 1
	end
	startCard += 2

	startDraw = startCard
	while(input[startDraw] != '|')
		startDraw += 1
	end
	startDraw += 2


	endDraw = startDraw
	while(input[endDraw] != '\n')
		endDraw += 1
	end

	acc = 0
	for i in range(0, stop=length(input), step=endDraw)
		seen = Set{String}()
		for j in range(i + startCard, stop=(i + startDraw - 3), step=3)
			push!(seen, input[j:j+1])
		end
		
		got = 0
		for j in range(i + startDraw, stop=(i + endDraw - 1), step=3)
			if input[j:j+1] in seen
				got += 1
			end
		end

		if got == 0
			continue
		end

		acc += 1 << (got - 1)
	end

	return acc
end


function two(input)
	startCard = 1
	while (input[startCard] != ':')
		startCard += 1
	end
	startCard += 2

	startDraw = startCard
	while (input[startDraw] != '|')
		startDraw += 1
	end
	startDraw += 2


	endDraw = startDraw
	while (input[endDraw] != '\n')
		endDraw += 1
	end

	wins = Array{Int, 1}()
	for i in range(0, stop=length(input), step=endDraw)
		seen = Set{String}()
		for j in range(i + startCard, stop=(i + startDraw - 3), step=3)
			push!(seen, input[j:j+1])
		end

		got = 0
		for j in range(i + startDraw, stop=(i + endDraw - 1), step=3)
			if input[j:j+1] in seen
				got += 1
			end
		end

		push!(wins, got)
	end

	adjustedWins = Vector{Int}(undef, length(wins))
	adjustedWins[length(wins)] = 0
	for i in range(length(wins) - 1, stop=1, step=-1)
		acc = 0
		for j in range(i + 1, stop=(i + wins[i]), step=1)
			acc += adjustedWins[j]
		end
		adjustedWins[i] = acc + wins[i]
	end

	return sum(adjustedWins) + length(wins)
end



using Test
@testset "works for example input" begin
	input = read("example.txt", String)
	@test one(input) == 13
	@test two(input) ==30
end

input = read("input.txt", String)
@info "Part one: $(one(input))"
@info "Part two: $(two(input))"

