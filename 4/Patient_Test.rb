if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end


require_relative 'Patient'


class Patient_Test
  def initialize
    self.menu()
    self.take_action()
  end

  def menu
    puts "Test for Patient class"
    puts
    puts "Actions:"
    puts "1 - Surname"
    puts "2 - Name"
    puts "3 - Patronymic"
    puts "4 - Birthdate"
    puts "5 - All"
    puts "0 - Exit"
    puts ""
  end

  def take_action
    action = gets.chomp
    while action != "0"
      if (0..5).map{|el| el.to_s}.include? action
        puts self.act(action.to_i, self.get_data(action.to_i))
      else
        puts "Invalid command"
      end
      action = gets.chomp
    end
  end

  def act(action, data)
    case action
    when 1
      Patient.surname_set(data)
    when 2
      Patient.name_set(data)
    when 3
      Patient.patronymic_set(data)
    when 4
      Patient.birthdate_set(data)
    when 5
      Patient.new(*data)
    end
  end

  def get_data(action)
    case action
    when 1
      puts "Enter surname:"
      gets.chomp
    when 2
      puts "Enter name:"
      gets.chomp
    when 3
      puts "Enter patronymic:"
      gets.chomp
    when 4
      puts "Enter birthdate:"
      gets.chomp
    when 5
      Array.new(4) {|el| self.get_data(el + 1)}
    end
  end

end

Patient_Test.new()