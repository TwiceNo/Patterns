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

def standard_deviation(lines, frequency)
	lines.sort_by { |line, result = most_frequent(to_alpha(line.downcase.chars))| 
		Math.sqrt((result[1] ** 2 - frequency[result[0]] ** 2).abs) }
end


vowels = ["a", "e", "i", "o", "u"] 
consonants = ("a".."z").to_a.reject { |e| vowels.include? e }
frequency = from_file("frequency.txt").map { |line| 
	line.split(" ") }.to_h.transform_values { |v| v.to_f }

lines = from_file("text.txt")

puts lines
puts standard_deviation(lines, frequency)
puts most_frequent(to_alpha(lines[0].downcase.chars))
puts most_frequent(to_alpha(lines[1].downcase.chars))
puts most_frequent(to_alpha(lines[2].downcase.chars))
puts most_frequent(to_alpha(lines[3].downcase.chars))
