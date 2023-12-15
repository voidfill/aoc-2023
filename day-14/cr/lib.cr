require "log"

enum Field
	Empty
	Round
	Cube
end

alias Dish = Array(Array(Field))

def parse(s : String) : Dish
	ret = Array(Array(Field)).new
	s.each_line do |line|
		a = Array(Field).new
		line.each_char do |c|
			if c == '#'
				a << Field::Cube
			elsif c == 'O'
				a << Field::Round
			else
				a << Field::Empty
			end
		end

		ret << a
	end

	ret
end

def l(d : Dish) : Dish
	ret = Array(Array(Field)).new
	d.each do |row|
		nr = Array(Field).new

		seenRounds = 0
		i = 0
		j = 0
		while i < row.size
			if row[i] == Field::Cube
				if seenRounds > 0
					(0..seenRounds - 1).each do 
						nr << Field::Round
						j = j + 1
					end
				end
				seenRounds = 0
				
				while j < i
					nr << Field::Empty
					j = j + 1
				end
				i = i + 1
				j = j + 1
				nr << Field::Cube
			elsif row[i] == Field::Round
				seenRounds = seenRounds + 1
				i = i + 1
			else
				i = i + 1
			end
		end

		if seenRounds > 0
			(0..seenRounds - 1).each do 
				nr << Field::Round
				j = j + 1
			end
		end

		while j < i
			nr << Field::Empty
			j = j + 1
		end
		
		ret << nr
	end

	ret
end

def r(d : Dish) : Dish
	ret = Array(Array(Field)).new
	
	d.each do |row|
		nr = Array(Field).new(row.size, Field::Empty)

		seenRounds = 0
		wr = row.size - 1

		(row.size - 1).downto(0) do |i|
			if row[i] == Field::Cube
				if seenRounds > 0
					(0..seenRounds - 1).each do 
						nr[wr] = Field::Round
						wr = wr - 1
					end
				end
				seenRounds = 0
				
				while wr > i
					nr[wr] = Field::Empty
					wr = wr - 1
				end
				nr[wr] = Field::Cube
				wr = wr - 1
			elsif row[i] == Field::Round
				seenRounds = seenRounds + 1
			end
		end


		if seenRounds > 0
			(0..seenRounds - 1).each do 
				nr[wr] = Field::Round
				wr = wr - 1
			end
		end

		ret << nr
	end

	ret
end

def u(d : Dish) : Dish
	ret = Array(Array(Field)).new

	(0..d.size - 1).each do |i|
		ret << Array(Field).new(d[0].size, Field::Empty)
	end

	(0..d[0].size - 1).each do |i|
		seenRounds = 0
		wr = 0

		(0..d.size - 1).each do |j|
			cur = d[j][i]

			if cur == Field::Round
				seenRounds = seenRounds + 1
			elsif cur == Field::Cube
				if seenRounds > 0
					(0..seenRounds - 1).each do |k|
						ret[wr][i] = Field::Round
						wr = wr + 1
					end
				end
				seenRounds = 0

				while wr < j
					ret[wr][i] = Field::Empty
					wr = wr + 1
				end
				
				ret[wr][i] = Field::Cube
				wr = wr + 1
			end
		end
		if seenRounds > 0
			(0..seenRounds - 1).each do |k|
				ret[wr][i] = Field::Round
				wr = wr + 1
			end
		end
	end

	ret
end

def d(d : Dish) : Dish
	ret = Array(Array(Field)).new

	(0..d.size - 1).each do |i|
		ret << Array(Field).new(d[0].size, Field::Empty)
	end

	(0..d[0].size - 1).each do |i|
		seenRounds = 0
		wr = d.size - 1

		(d.size - 1).downto(0) do |j|
			cur = d[j][i]

			if cur == Field::Round
				seenRounds = seenRounds + 1
			elsif cur == Field::Cube
				if seenRounds > 0
					(0..seenRounds - 1).each do |k|
						ret[wr][i] = Field::Round
						wr = wr - 1
					end
				end
				seenRounds = 0

				while wr > j
					ret[wr][i] = Field::Empty
					wr = wr - 1
				end
				
				ret[wr][i] = Field::Cube
				wr = wr - 1
			end
		end
		if seenRounds > 0
			(0..seenRounds - 1).each do |k|
				ret[wr][i] = Field::Round
				wr = wr - 1
			end
		end
	end

	ret
end

def toString(d : Dish) : String
	ret = "\n"
	d.each do |row|
		row.each do |f|
			if f == Field::Cube
				ret = ret + "#"
			elsif f == Field::Round
				ret = ret + "O"
			else
				ret = ret + "."
			end
		end
		ret = ret + "\n"
	end

	ret
end

def loadOnSouth(d : Dish) : Int32
	ret = 0
	v = d.size

	d.each do |row|
		row.each do |f|
			if f == Field::Round
				ret = ret + v
			end
		end
		v = v - 1
	end

	ret
end

def one(input : String): Int32 | Nil
	loadOnSouth(u(parse(input)))
end

def two(input : String) : Int32 | Nil
	i = parse(input)
	seen = Hash(String, Int32).new

	done = 0
	loop = 0
	(0..1000000000 - 1).each do |a|
		i = r(d(l(u(i))))
		s = toString(i)
		if seen.has_key?(s)
			loop = a - seen[s]
			done = a + 1
			break
		end
		seen[s] = a
	end

	((1000000000 - done) % loop).times do
		i = r(d(l(u(i))))
	end
	
	loadOnSouth(i)
end
