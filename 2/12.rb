#1 5 9 10

def from_file(filename)
	File.open(filename, "r") {|file| file.read.split("\n")}
end

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

def mean(line, letters)
	line.select { |e| letters.include? e }.length
end

def to_alpha(line)
	line.reject { |el| not ("a".."z").to_a.include? el }
end

def most_frequent(line)
	Hash[ line.uniq.map { |letter| 
		[letter, line.count(letter).to_f / line.length] } ].max_by { |key, value| value }
end

def standard_deviation(a, b)
	Math.sqrt((a ** 2 - b ** 2).abs)
end

def by_frequent(lines, frequency)
	lines.sort_by { |line, result = most_frequent(to_alpha(line.downcase.chars))| 
		standard_deviation(result[1], frequency[result[0]]) }
end

def mirror_codes(line)
	mirror = line.map { |e| e.ord }.reject.with_index { |idx| line[idx] != line[-idx] }
	mirror.sum
end

def by_ascii_code(lines)
	lines.sort_by { 
		|line| standard_deviation(line.chars.max_by { 
			|letter| letter.ord }.ord, mirror_codes(line.chars)) }
end

def triads(line)
	line[1...-1].select.with_index { |value, idx| line[idx - 1] == line[idx + 1]}.count
end

def by_triads(lines)
	lines.sort_by { |line| triads(line.chars) }
end


vowels = %w[a e i o u]
consonants = ("a".."z").to_a.reject { |e| vowels.include? e }
frequency = from_file("frequency.txt").map { |line| 
	line.split(" ") }.to_h.transform_values { |v| v.to_f }

lines = from_file("text.txt")

puts lines
puts
puts by_triads(lines)
