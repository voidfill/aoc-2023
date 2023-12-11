require "log"

def boolMapToString(bm : Array(Array(Bool))) : String
	ret = ""

	bm.each do |row|
		row.each do |b|
			ret += b ? '#' : '.'
		end
		ret += "\n"
	end

	ret
end

def toBoolMap(input : String, doExpandHorizontals : Bool) : Array(Array(Bool))
	ret = Array(Array(Bool)).new

	input.each_line do |l|
		row = Array(Bool).new
		isEmpty = doExpandHorizontals
		l.each_char do |c|
			if c == '#'
				isEmpty = false
			end
			row.push(c == '#')
		end
		ret.push(row)
		if isEmpty
			ret.push(row.clone())
		end
	end

	ret
end

def boolMapToPositions(bm : Array(Array(Bool))) : Array(Tuple(Int64, Int64))
	ret = Array(Tuple(Int64, Int64)).new

	bm.each_with_index do |row, i|
		row.each_with_index do |b, j|
			if b
				ret.push({i.to_i64, j.to_i64})
			end
		end
	end

	ret
end

def positionsDistance(positions : Array(Tuple(Int64, Int64))) : Int64
	acc = 0.to_i64

	positions.each_with_index do |p, i|
		if i == positions.size - 1
			break
		end
		
		(i + 1..positions.size - 1).each do |j|
			acc += (p[0] - positions[j][0]).abs()
			acc += (p[1] - positions[j][1]).abs()
		end
	end

	acc
end

def emptyRows(bm : Array(Array(Bool))) : Array(Int64)
	ret = Array(Int64).new
	
	bm.each_with_index do |row, i|
		isEmpty = true

		row.each do |v|
			if v
				isEmpty = false
				break
			end
		end

		if isEmpty
			ret.push(i.to_i64)
		end
	end

	ret
end

def emptyColumns(bm : Array(Array(Bool))) : Array(Int64)
	ret = Array(Int64).new

	(0..bm[0].size - 1).each do |i|
		isEmpty = true
		bm.each_with_index do |r, j|
			if bm[j][i]
				isEmpty = false
				break
			end
		end

		if isEmpty
			ret.push(i)
		end
	end

	ret
end

def sol(input : String, sizeMultiplier : Int64) : Int64 | Nil
	bm = toBoolMap(input, false)
	pos = boolMapToPositions(bm)

	rows = emptyRows(bm)
	columns = emptyColumns(bm)

	rows.reverse().each do |r|
		pos.map! do |p|
			if p[0] > r
				{p[0] + sizeMultiplier - 1, p[1]}
			else
				p
			end
		end
	end

	columns.reverse().each do |c|
		pos.map! do |p|
			if p[1] > c
				{p[0], p[1] + sizeMultiplier - 1}
			else
				p
			end
		end
	end

	positionsDistance(pos)
end
