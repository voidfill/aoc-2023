require "log"

def distanceTraveled(time : Int64, buttonPressed : Int64): Int64
	(time - buttonPressed) * buttonPressed
end

def one(input : String): Int64 | Nil
	nums = Array(Int64).new
	input.scan(/\d+/) { |match| nums << match[0].to_i64 }

	times = nums[0..(nums.size >> 1) - 1]
	records = nums[(nums.size >> 1)..nums.size]

	acc = 1.to_i64
	records.each_with_index do |record, index|
		time = times[index]

		beat = 0
		(1..time).each do |i|
			if (time - i) * i > record
				beat = beat + 1
			end
		end

		acc = acc * beat
	end
	return acc
end


def two(input : String) : Int64 | Nil
	nums = Array(String).new
	input.scan(/\d+/) { |match| nums << match[0] }

	time = nums[0..(nums.size >> 1) - 1].join("").to_i64
	record = nums[(nums.size >> 1)..nums.size].join("").to_i64

	beat = 0.to_i64
	(1..time).each do |i|
		if (time - i) * i > record
			beat = beat + 1
		end
	end

	return beat
end
