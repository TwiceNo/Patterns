def minimum(arr)
	return arr.min
end

def maximum(arr)
	return arr.max
end

def sum(arr)
	return arr.sum
end

def product(arr)
	return arr.inject(1) {|res, el| res * el}
end


def from_keyboard()
	return Array.new(ARGV[0].to_i) { STDIN.gets.to_i }
end

def from_file(filename)
	text = File.open(filename, "r") {|file| file.read.split("\n")}
	return text.map {|el| el.to_i}
end

arr = from_file("file.txt")

puts "Minimum: #{minimum(arr)}"
puts "Maximum: #{maximum(arr)}"
puts "Sum: #{sum(arr)}"
puts "Product: #{product(arr)}"