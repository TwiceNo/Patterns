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

puts "Enter line:"
line = STDIN.gets.chomp

print "Is palindrome: "
puts palindrome(line)