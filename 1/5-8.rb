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
	return gcd(a, b) == 1
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



x = ARGV[0].to_i
sum(x.clone)
multi(x.clone)
minimum(x.clone)
maximum(x.clone)
num_of_not_coprimes(x.clone)