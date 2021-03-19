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


a = Array.new(5) { STDIN.gets.to_i }
puts
b = Array.new(5) { STDIN.gets.to_i }

puts coincident(a, b)