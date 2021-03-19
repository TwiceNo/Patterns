def minimum(arr)
	return arr.min
end

def maximum(arr)
	return arr.max
end

def sum(arr)
	return arr.sum
end

def product(arr)
	return arr.inject(1) {|res, el| res * el}
end


def from_keyboard(n)
	return Array.new(n) { STDIN.gets.to_i }
end

def from_file(filename)
	text = File.open(filename, "r") {|file| file.read.split("\n")}
	return text.map {|el| el.to_i}
end

def process(arr)
	puts "Minimum: #{minimum(arr)}"
	puts "Maximum: #{maximum(arr)}"
	puts "Sum: #{sum(arr)}"
	puts "Product: #{product(arr)}"
end


if ARGV.length < 2
	puts "Arguments Error"
	puts
	puts "From file: 0 <filename>"
	puts "From keyboard: 1 <array lentgh>"
else
	if ARGV[0].to_i == 0 and File.file?(ARGV[1])
		process(from_file(ARGV[1]))
	elsif ARGV[0].to_i == 1 and ARGV[1].upcase == ARGV[1].downcase
		process(from_keyboard(ARGV[1].to_i))
	end
end