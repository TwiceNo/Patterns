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


puts "Length:"
n = gets.to_i

puts "Elements:"
arr = Array.new(n) {gets.to_i}

puts "Minimum: #{minimum(arr)}"
puts "Maximum: #{maximum(arr)}"
puts "Sum: #{sum(arr)}"
puts "Product: #{product(arr)}"