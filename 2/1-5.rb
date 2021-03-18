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
	n = ARGV[0].to_i
	arr = Array.new() 
	n.times do 
		arr.push(STDIN.gets.to_i)
	end
	return arr
end

arr = from_keyboard()

puts "Minimum: #{minimum(arr)}"
puts "Maximum: #{maximum(arr)}"
puts "Sum: #{sum(arr)}"
puts "Product: #{product(arr)}"