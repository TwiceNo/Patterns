def max(arr)
	return arr.max
end

def to_array(line)
	return line.split(" ").map { |e| e.to_i }
end

puts "Enter line:"
line = STDIN.gets

print "Max: "
puts max(to_array(line))