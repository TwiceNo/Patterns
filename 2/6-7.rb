#10 22 34 46 58

def coincident(a, b)
	return a.keep_if.with_index { |el, i| el == b[i] }.length
end

def relate(arr, a, b)
	return arr.select { |e| e > a and e < b }
end

def positive_negative(arr)
	positive = arr.select {|el| el > 0}
	negative = arr.select {|el| el < 0}
	return positive, negative
end

def element_as_sum(arr)
	return arr.map { |el| (arr - [el]).combination(2).map { |e| e.sum }.include? (el) }.count true
end

def locals(arr, a, b)
	temp = []
	for i in 1...arr.length - 1 do
		if arr[i] < arr[i - 1] and arr[i] < arr[i + 1]
			temp.push(arr[i])
		end
	end
	count = 0
	temp.each do |el|
		if el > a and el < b
			count += 1
		end
	end
	return count
end

def from_file(filename)
	text = File.open(filename, "r") {|file| file.read.split("\n")}
	return text.map {|el| el.to_i}
end

def get_interval()
	puts "Enter interval"
	print "A = "; a = STDIN.gets.to_i
	print "B = "; b = STDIN.gets.to_i
	return a, b
end

def process(param, a, b)
	print "\nTask "
	puts param
	case param
	when 10
		print show(0)
		if a.length <= b.length
			puts coincident(a, b)
		else
			puts coincident(b, a)
		end
	when 22
		interval = get_interval()
		print show(5)
		puts locals(a, interval[0], interval[1])
	when 34
		interval = get_interval()
		print show(1)
		p relate(a, interval[0], interval[1])
	when 46
		tmp = positive_negative(a)
		print show(2); p tmp[0]
		print show(3); p tmp[1]
	when 58
		print 
		puts element_as_sum(a)
	else
		puts show(param)
	end
end

def show(line)
	case line
	when 0
		"Amount of coincident elements: "
	when 1
		"Elements belonging to the interval: "
	when 2
		"Positive:"
	when 3
		"Negative:"
	when 4
		"Amount of elements that can be obtained as the sum: "
	when 5 
		"Locals minimums in interval: " 
	else
		"Unknown task"
	end
end



a = from_file("a.txt")
b = from_file("b.txt")

print "Array A: "; p a
print "Array B: "; p b


for el in ARGV do
	process(el.to_i, a, b)
end
