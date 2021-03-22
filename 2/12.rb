def from_file(filename)
	File.open(filename, "r") {|file| file.read.split("\n")}
end

def by_length(lines)
	lines.sort_by { |line| line.length }
end

def by_words(lines)
	lines.sort_by { |line| line.split(" ").length }
end


lines = from_file("text.txt")
puts by_words(lines)
