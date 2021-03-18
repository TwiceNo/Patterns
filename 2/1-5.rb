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
	arr = Array.new(ARGV[0].to_i) { STDIN.gets.to_i }
	return arr
end

arr = from_keyboard()

puts "Minimum: #{minimum(arr)}"
puts "Maximum: #{maximum(arr)}"
puts "Sum: #{sum(arr)}"
puts "Product: #{product(arr)}"