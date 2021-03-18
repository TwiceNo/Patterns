def sum(num)
	sum = 0
	while num > 0 do
		sum += num % 10
		num /= 10
	end
	return sum
end


def multi(num)
	mul = 1
	while num > 0 do
		mul *= num % 10
		num /= 10
	end
	return mul
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
	return min
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
	return max
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


def process(num, par)
	case par
	when 0
		puts "Help:\n"
		puts "1 -- sum of digits"
		puts "2 -- multiplication of digits"
		puts "3 -- minimal digit"
		puts "4 -- maximal digit"
		puts "5 -- amount of not coprime even numbers"
		puts "6 -- maximal digit aliquant 3"
		puts "7 -- method 3"
		puts 
	when 1
		puts "Sum of digits: #{sum(num)}"
	when 2
		puts "Multiplication of digits: #{multi(num)}"
	when 3
		puts "Minimal digit: #{minimum(num)}"
	when 4
		puts "Maximal digit: #{maximum(num)}"
	when 5
		puts "Amount of not coprime even numbers: #{not_coprime(num)}"
	when 6
		puts "Maximal digit aliquant 3: #{aliquant(num)}"
	when 7 
		puts "Method 3: #{method_3(num)}"
	else
		puts "Unknown operation. Put 0 for Help."
	end
end


if ARGV.length < 2
	puts "Hello, World!"
else
	x = ARGV[0].to_i
	param = ARGV[1, ARGV.length - 1].map {|p| p.to_i}
	for par in param do
		process(x, par)
	end
end