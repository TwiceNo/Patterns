#4 11 15

def dates(line)
  line.scan(/([0-9]|[1-2][0-9]|[3][0-1]) (January|February|March|April|May|June|July|August|September|October|November|December) ([1-2][0-9]{3})/)
end

def lesser_than(line)
  line.scan(/[0-4]/).count
end

puts "Enter line:"
line = gets.chomp
puts
p lesser_than(line)
