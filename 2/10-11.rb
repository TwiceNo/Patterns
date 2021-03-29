#4 11 15

def dates(line)
  line.scan(/([0-9]|[1-2][0-9]|[3][0-1]) (January|February|March|April|May|June|July|August|September|October|November|December) ([1-2][0-9]{3})/)
end

def lesser_than(line)
  line.scan(/[0-4]/).count
end

def unused(line)
  ("a".."z").to_a.reject { |letter| line.scan(/[a-zA-Z]/).include? letter }
end

def greater_than(line)
  line.scan(/[6-9]/).count
end


def process(param, lines)
  puts "\nTask #{param}\n"
  puts show(param)
  case param
  when 10
    puts dates(lines)
  when 4
    puts lesser_than(lines)
  when 11
    puts unused(lines)
  when 15
    puts greater_than(lines)
  end
end

def show(param)
  case param
  when 10
    "Dates:"
  when 4
    "X < 5"
  when 11
    "Unused letters:"
  when 15
    "X > 5"
  else
    "Unknown task"
  end
end


puts "Enter line:"
line = gets.chomp

ARGV.each { |el|
  process(el.to_i, line)
}
