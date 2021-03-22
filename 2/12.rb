def from_file(filename)
	File.open(filename, "r") {|file| file.read.split("\n")}
end

def by_length(lines)
	lines.sort_by { |line| line.length }
end

def print_lines(lines)
	lines.length.times do |line|
		puts line
	end
end

lines = from_file("text.txt")
puts by_length(lines)
