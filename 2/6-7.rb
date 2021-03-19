#10 22 34 46 58

def coincident(a, b)
	count = 0
	a.length.times do |i|
		if a[i] == b[i]
			count += 1
		end
	end
	return count
end

def relate(arr, a, b)
	tmp = Array.new()
	for el in arr do
		if el > a and el < b
			tmp.push(el)
		end
	end
	return tmp
end

def positive_negative(arr)
	positive = Array.new()
	negative = Array.new()
	for el in arr do
		if el > 0
			positive.push(el)
		elsif el < 0
			negative.push(el)
		end
	end
	return positive.concat(negative)
end

def element_as_sum(arr)
	count = 0
	n = arr.length
	for i in 0...n do
		for j in 0...n do
			for k in j...n do
				if i != k and 
				   i != j and 
				   j != k and 
				   arr[i] == arr[j] + arr[k]
					count += 1
				end
			end
		end
	end
	return count
end



a = Array.new(5) { STDIN.gets.to_i }
puts
puts element_as_sum(a)