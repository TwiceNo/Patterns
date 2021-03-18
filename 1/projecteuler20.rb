def factorial(num)
	res = 1
	while num > 1
		res *= num
		num -= 1
	end
	return res
end

def sum(num)
	return num.to_s.split(//).map {|n| n.to_i}.sum
end


fact = factorial(100)
puts "100! = #{fact}"
puts "Sum of digits: #{sum(fact)}"