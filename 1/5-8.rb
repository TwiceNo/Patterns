num = ARGV[0].to_i
sum = 0
while num > 0 do
	sum += num % 10
	num /= 10
end
puts "Sum = #{sum}"