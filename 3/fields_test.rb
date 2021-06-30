require_relative 'Employee.rb'


def test(field, value)
  begin
    puts "Employee.#{field}=('#{value.encode "UTF-8"}')"
    eval("Employee.#{field}=('#{value.encode "UTF-8"}')")
    puts eval("Employee.reformat_#{field}('#{value.encode "UTF-8"}')")
  rescue
    puts "Exception occurred"
  end
end

def run_test(option)
  case option
  when 1
    test("name", gets.chomp)
  when 2
    test("birthdate", gets.chomp)
  when 3
    test("phone", gets.chomp)
  when 4
    test("email", gets.chomp)
  when 5
    test("passport", gets.chomp)
  else
    puts "Unknown command"
  end
end


puts "Employee's class fields test"
puts
puts "Menu:"
puts "1: name"
puts "2: birthdate"
puts "3: phone"
puts "4: email"
puts "5: passport"
puts "0: exit"
puts

# puts "Action: "
# action = gets.chomp.to_i
# while action != 0
#   puts "Enter the value: "
#   run_test(action)
#   puts "Action: "
#   action = gets.chomp.to_i
# end

puts gets.chomp.encoding
puts "офуылаодф".encoding

test("name", "риддл том марволо")
