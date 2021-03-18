def sum(num)
	sum = 0
	while num > 0 do
		sum += num % 10
		num /= 10
	end
	puts "Sum = #{sum}"
end


def multi(num)
	mul = 1
	while num > 0 do
		mul *= num % 10
		num /= 10
	end
	puts "Multiplication = #{mul}"
end


def minimum(num)
	min = num.clone
	while num > 0 do
		digit = num % 10
		if digit < min 
			min = digit.clone
		end
		num /=10
	end
	puts "Minimal = #{min}"
end


def maximum(num)
	max = 0
	while num > 0 do
		digit = num % 10
		if digit > max 
			max = digit.clone
		end
		num /=10
	end
	puts "Maximal = #{max}"
end


def not_coprime(num)
	count = 0
	for i in (2..num - 1).step(2) do
		if (num.gcd i) != 1
			count += 1
		end
	end
	return count
end


def aliquant(num)
	max = 0
	while num > 0 do
		digit = num % 10
		if digit > max and digit % 3 != 0
			max = digit
		end
		num /=10
	end
	return max
end


def least_divisor(num)
	for i in 2..num / 2 do
		if num % i == 0
			return i
		end
	end
	return 1
end


def factor(num)
	least = least_divisor(num)
	f = num - 1
	while f > 0
		if (num.gcd f) != 1 and f % least != 0 
			return f
		end
		f -= 1
	end
end


def lesser(num)
	sum = 0
	while num > 0 do
		digit = num % 10
		if digit < 5
			sum += digit
		end
		num /= 10
	end
	return sum
end


def method_3(num)
	return factor(num) * lesser(num)
end


x = ARGV[0].to_i
puts method_3(x)