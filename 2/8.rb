#4 11 15

def max(arr)
	return arr.max
end

def to_array(line)
	return line.split(" ").map { |e| e.to_i }
end

def palindrome(line)
	return line == line.reverse
end

def words_count(line)
	return line.split(" "). length
end

def unique_digits(line)
	return line.chars.uniq.length
end

puts "Enter line:"
line = STDIN.gets.chomp

puts unique_digits(line)