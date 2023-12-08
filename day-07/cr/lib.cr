require "log"

def cardToVal(card : String) : Int32
	case card
	when "A"
		return 14
	when "K"
		return 13
	when "Q"
		return 12
	when "J"
		return 11
	when "T"
		return 10
	else
		return card.to_i32
	end
end

enum Handtype
	Five = 0
	Four
	FullHouse
	Three
	Two
	One
	High
end

def handValue(a : Array(Int32)) : Handtype
	ssize = (Set.new a).size

	if ssize == 5
		return Handtype::High
	elsif ssize == 4
		return Handtype::One
	elsif ssize == 1
		return Handtype::Five
	end

	d = Hash(Int32, Int32).new

	a.each do |c|
		if d.has_key?(c)
			d[c] += 1
		else
			d[c] = 1
		end
	end

	if d.size == 2
		if d.values.any?(4)
			return Handtype::Four
		end
		return Handtype::FullHouse

	elsif d.size == 3
		if d.values.any?(3)	
			return Handtype::Three
		end
	end

	return Handtype::Two
end

def comparator(x : Tuple(Handtype, Array(Int32), Int32), y : Tuple(Handtype, Array(Int32), Int32)) : Int32
	if x[0] != y[0]
		return y[0].value - x[0].value
	end

	(0..4).each do |i|
		if x[1][i] == y[1][i]
			next
		end

		return x[1][i] - y[1][i]
	end

	0
end

def one(input : String) : Int32 | Nil
	cardsAndBids = Array(Tuple(Handtype, Array(Int32), Int32)).new


	input.split("\n").each do |line|
		spl = line.split(" ")
		values = spl[0].split("").map { |c| cardToVal(c) }
		cardsAndBids.push({ handValue(values), values, spl[1].to_i32 })
	end

	cardsAndBids.sort!{|x, y| comparator(x, y)}

	i = 1
	acc = 0
	cardsAndBids.each do |x|
		acc += x[2] * i
		i += 1
	end

	acc
end

def cardToVal2(card : String) : Int32
	case card
	when "A"
		return 14
	when "K"
		return 13
	when "Q"
		return 12
	when "J"
		return 1
	when "T"
		return 10
	else
		return card.to_i32
	end
end

def handValue2(a : Array(Int32)) : Handtype
	s = Set.new a
	ssize = s.size

	if ssize == 1
		return Handtype::Five
	end

	if !s.includes?(1)
		return handValue(a)
	end

	if ssize == 2
		if s.includes?(1)
			return Handtype::Five
		end
		return Handtype::Four
	end

	if ssize == 5
		if s.includes?(1)
			return Handtype::One
		end
		return Handtype::High
	end

	Log.info { "missed case, a: '#{a}'" }

	return Handtype::High
end

def handValue3(a : Array(Int32)) : Handtype
	hasJoker = false
	highest = 0
	highestCard = 0

	d = Hash(Int32, Int32).new

	a.each do |c|
		if c == 1
			hasJoker = true
			next
		end

		if d.has_key?(c)
			d[c] += 1
		else
			d[c] = 1
		end
	end

	if !hasJoker
		return handValue(a)
	end

	if d.size == 0
		return Handtype::Five
	end

	d.each do |k, v|
		if v > highest
			highest = v
			highestCard = k
		end
	end

	m = a.map { |i| i == 1 ? highestCard : i }

	return handValue(m)
end

def two(input : String) : Int32 | Nil
	cardsAndBids = Array(Tuple(Handtype, Array(Int32), Int32)).new


	input.split("\n").each do |line|
		spl = line.split(" ")
		values = spl[0].split("").map { |c| cardToVal2(c) }
		cardsAndBids.push({ handValue3(values), values, spl[1].to_i32 })
	end

	cardsAndBids.sort!{|x, y| comparator(x, y)}

	i = 1
	acc = 0
	cardsAndBids.each do |x|
		acc += x[2] * i
		i += 1
	end

	acc
end
