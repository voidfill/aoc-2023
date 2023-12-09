require "log"

def extrapolate(a : Array(Int32)) : Int32
	if a.size < 2
		raise "Array too small"
	end

	res = Array(Int32).new

	allZero = true
	(0..a.size - 2).each do |i|
		v = a[i + 1] - a[i]
		res << v
		if v != 0
			allZero = false
		end
	end

	if !allZero
		return a.last + extrapolate(res)
	end
	
	a.last
end

def one(input : String): Int32 | Nil
	acc = 0
	input.each_line do |line|
		acc += extrapolate(line.split(" ").map(&.to_i32))
	end
	acc
end

def extrapolate2(a : Array(Int32)) : Int32
	if a.size < 2
		raise "Array too small"
	end

	res = Array(Int32).new

	allZero = true
	(0..a.size - 2).each do |i|
		v = a[i + 1] - a[i]
		res << v
		if v != 0
			allZero = false
		end
	end

	if !allZero
		return a.first - extrapolate2(res)
	end
	
	a.first
end

def two(input : String) : Int32 | Nil
	acc = 0

	input.each_line do |line|
		acc += extrapolate2(line.split(" ").map(&.to_i32))
	end
	acc
end
