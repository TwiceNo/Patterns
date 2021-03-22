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


def process(param, line)
	print "\nTask "
	puts param
	print show(param)
	case param
	when 0
		puts max(to_array(line))
	when 4
		puts palindrome(line)
	when 11
		puts words_count(line)
	when 15
		puts unique_digits(line)
	end
end


def show(line)
	case line
	when 0
		"Max: "
	when 4
		"Is palindrome: "
	when 11
		"Words: "
	when 15
		"Unique digits: "
	else
		"Unknown task\n"
	end
end


puts "Enter line:"
line = STDIN.gets.chomp

for el in ARGV do
	process(el.to_i, line)
end
