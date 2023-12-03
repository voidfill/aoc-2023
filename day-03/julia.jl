function one(input)
	acc = 0

	nextToSymbol = Set{Tuple{Int,Int}}()
	lines = split(input, "\n")
	for i in eachindex(lines)
		for j in eachindex(lines[i])
			char = lines[i][j]
			if char == '.' || (char >= '0' && char <= '9')
				continue
			end
			push!(nextToSymbol, (i, j + 1), (i + 1, j + 1), (i + 1, j), (i + 1, j - 1), (i, j - 1), (i - 1, j - 1), (i - 1, j), (i - 1, j + 1))
		end
	end

	for i in eachindex(lines)
		num = ""
		isPart = false

		for j in eachindex(lines[i])
			char = lines[i][j]
			if char >= '0' && char <= '9'
				if ((i, j) in nextToSymbol)
					isPart = true
				end
				num *= char
			else
				if isPart && length(num) > 0
					acc += parse(Int, num)
					isPart = false
				end
				num = ""
			end
		end

		if isPart && length(num) > 0
			acc += parse(Int, num)
			isPart = false
		end
		num = ""
	end

	return acc
end


function two(input)
	acc = 0

	gears = Dict{Tuple{Int,Int}, Tuple{Int, Int}}()
	ratios = Dict{Tuple{Int,Int},Array{Int, 1}}()
	lines = split(input, "\n")
	for i in eachindex(lines)
		for j in eachindex(lines[i])
			if lines[i][j] != '*'
				continue
			end

			ratios[(i, j)] = Array{Int, 1}()

			gears[(i, j + 1)] = (i, j)
			gears[(i + 1, j + 1)] = (i, j)
			gears[(i + 1, j)] = (i, j)
			gears[(i + 1, j - 1)] = (i, j)
			gears[(i, j - 1)] = (i, j)
			gears[(i - 1, j - 1)] = (i, j)
			gears[(i - 1, j)] = (i, j)
			gears[(i - 1, j + 1)] = (i, j)
		end
	end

	for i in eachindex(lines)
		num = ""
		adjacentGears = Set{Tuple{Int,Int}}()

		for j in eachindex(lines[i])
			char = lines[i][j]
			if char >= '0' && char <= '9'
				if (haskey(gears, (i, j)))
					push!(adjacentGears, gears[(i, j)])
				end
				num *= char
			else
				if length(num) > 0
					int = parse(Int, num)
					for gear in adjacentGears
						push!(ratios[gear], int)
					end
				end
				num = ""
				adjacentGears = Set{Tuple{Int,Int}}()
			end
		end

		if length(num) > 0
			int = parse(Int, num)
			for gear in adjacentGears
				push!(ratios[gear], int)
			end
		end
		num = ""
		adjacentGears = Set{Tuple{Int,Int}}()
	end

	for ratio in values(ratios)
		if length(ratio) > 1
			acc += prod(ratio)
		end
	end

	return acc
end


using Test
@testset "works for example input" begin
	input = read("example.txt", String)
	@test one(input) == 4361
	@test two(input) == 467835
end

input = read("input.txt", String)
@info "Part one: $(one(input))"
@info "Part two: $(two(input))"

