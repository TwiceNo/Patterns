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


def not_coprime(a, b)
	return gcd(a, b) != 1
end

def gcd(a, b)
	if b == 0
		return a
	else
		gcd(b, a.clone % b)
	end
end

def num_of_not_coprimes(num)
	count = 0
	for i in 2..num do
		if i % 2 == 0 and not_coprime(num, i)
			count += 1
		end
	end
	puts "Num of even not coprimes = #{count}"
end


def max_aliquant(num)
	max = 0
	while num > 0 do
		digit = num % 10
		if digit % 3 != 0 and digit > max 
			max = digit.clone
		end
		num /=10
	end
	puts "Maximal aliquant 3 = #{max}"
end


def sum_lesser(num)
	sum = 0
	while num > 0 do
		digit = num % 10
		if digit < 5
			sum += num % 10
			num /= 10
		end
	end
	return sum
end

def max_not_coprime(num)
	ld = least_divisor(num.clone)
	i = num.clone - 1
	while i > 0
		if not_coprime(num, i) and i % ld != 0 
			puts i
			return i
		end
		i -= 1
	end
end

def least_divisor(num)
	i = 2
	while i < num / 2
		if num % i == 0
			puts i
			return i
		end
		i += 1
	end
end

def method_3(num)
	puts "Method 3 = #{max_not_coprime(num.clone) * sum_lesser(num.clone)}"
end

x = ARGV[0].to_i
sum(x.clone)
multi(x.clone)
minimum(x.clone)
maximum(x.clone)
num_of_not_coprimes(x.clone)
max_aliquant(x.clone)
method_3(x.clone)