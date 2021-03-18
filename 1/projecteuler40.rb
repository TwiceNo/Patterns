def get_digit(n)
	curr_block = 0
	curr_upper = 0
	prev_upper = 0
	while curr_upper < n
		prev_upper = curr_upper
		curr_upper += 9 * 10 ** curr_block
		curr_block += 1
	end
	offset = n - prev_upper - 1
	sequence = 1
	while sequence * curr_block < offset
		sequence += 1
	end
	fraction = ""
	for i in prev_upper + 1..prev_upper + 1 + sequence do
		fraction += i.to_s
	end
	return fraction.split(//)[offset].to_i
end

def product()
	res = 1
	for i in 0..7 do
		res *= get_digit(10 ** i)
	end
	return res
end


puts product()
