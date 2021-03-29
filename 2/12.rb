#1 5 9 10

#Main methods

def by_length(lines)
	lines.sort_by { |line| line.length }
end

def by_words(lines)
	lines.sort_by { |line| line.split(" ").length }
end

def by_vowels_consonants(lines, vowels, consonants)
	lines.sort_by { |line|
		mean(to_alpha(line.downcase.chars), consonants) -
			mean(to_alpha(line.downcase.chars), vowels) }
end

def by_frequent(lines, frequency)
	lines.sort_by { |line, result = most_frequent(to_alpha(line.downcase.chars))|
		standard_deviation(result[1], frequency[result[0]]) }
end

def by_ascii_code(lines)
	lines.sort_by {
		|line| standard_deviation(line.chars.max_by {
			|letter| letter.ord }.ord, mirror_codes(line.chars)) }
end

def by_triads(lines)
	lines.sort_by { |line| triads(line.chars) }
end

def by_after_nums(lines)
	lines.sort_by { |line| after_nums(line) }
end


#Submethods in call order

def from_file(filename)
	File.open(filename, "r") {|file| file.read.split("\n")}
end

def mean(line, letters)
	line.select { |e| letters.include? e }.length
end

def to_alpha(line)
	line.reject { |el| not ("a".."z").to_a.include? el }
end

def most_frequent(line)
	Hash[ line.uniq.map { |letter| 
		[letter, line.count(letter).to_f / line.length] } ].max_by { |_, value| value }
end

def standard_deviation(a, b)
	Math.sqrt((a ** 2 - b ** 2).abs)
end

def mirror_codes(line)
	line.map { |e| e.ord }.reject.with_index { |idx| line[idx] != line[-idx] }.sum
end

def triads(line)
	line[1...-1].select.with_index { |_, idx| line[idx - 1] == line[idx + 1]}.count
end

def after_nums(line)
	line.split(/[0-9]+/).map { |part| part[0] == " " ? part.split(" ").count : 0 }.max
end



vowels = %w[a e i o u]
consonants = ("a".."z").to_a.reject { |e| vowels.include? e }
frequency = from_file("frequency.txt").map { |line| 
	line.split(" ") }.to_h.transform_values { |v| v.to_f }

lines = from_file("text2.txt")

puts lines
puts
puts by_after_nums(lines)
