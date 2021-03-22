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
	case param
	when 0
		print "Max: "
		puts max(to_array(line))
	when 4
		print "Is palindrome: "
		puts palindrome(line)
	when 11
		print "Words: "
		puts words_count(line)
	when 15
		print "Unique digits: "
		puts unique_digits(line)
	else
		puts "Unknown task"
	end
end


puts "Enter line:"
line = STDIN.gets.chomp

for el in ARGV do
	process(el.to_i, line)
end
