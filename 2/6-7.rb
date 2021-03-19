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


a = Array.new(5) { STDIN.gets.to_i }
puts
puts relate(a, STDIN.gets.to_i, STDIN.gets.to_i)