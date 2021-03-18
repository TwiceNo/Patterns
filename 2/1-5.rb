def minimum(arr)
	min = arr[0]
	for el in arr do
		if el < min
			min = el
		end
	end
	return min
end

def maximum(arr)
	max = arr[0]
	for el in arr do
		if el > max
			max = el
		end
	end
	return max
end

def sum(arr)
	s = 0
	for el in arr do
		s += el
	end
	return s
end

def product(arr)
	prod = 1
	for el in arr do
		prod *= el
	end
	return prod
end


puts "Length:"
n = gets.to_i

puts "Elements:"
arr = Array.new(n) {gets.to_i}

puts "Minimum: #{minimum(arr)}"
puts "Maximum: #{maximum(arr)}"
puts "Sum: #{sum(arr)}"
puts "Product: #{product(arr)}"