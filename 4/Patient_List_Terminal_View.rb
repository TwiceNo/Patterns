if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end


require_relative 'Patient_List'


class Patient_List_Terminal_View
  attr_accessor :patient_list

  def initialize
    @patient_list = Patient_List.new
    self.menu
    self.take_action
  end

  def menu
    puts "Menu"
    puts
    puts "1 - Add"
    puts "2 - Show"
    puts "3 - Find"
    puts "4 - Edit"
    puts "5 - Delete"
    puts "6 - Save"
    puts "7 - Sort"
    puts "0 - Exit"
  end

  def take_action
    action = gets.chomp
    while action != "0"
      puts self.act(action.to_i)
      action = gets.chomp
    end
  end

  def act(action)
    case action
    when 1
      @patient_list.add(self.get_data(action))
      "Successfully added"
    when 2
      self.show(show_all=true)
    when 3
      line, fields = *self.get_data(action)
      list = []
      fields.each do |el|
        list += @patient_list.find_by(el, line)
      end
      self.show("#{list.length} results found", list)
    when 4
      self.select_note
      self.edit
    when 5
      self.select_note
      @patient_list.delete
    when 6
      self.save
    when 7
      field = self.get_data(action)
      self.show("Sorted by field #{field}", @patient_list.sort_by(field))
    else
      "Invalid command"
    end
  end

  def get_data_for_field(action)
    case action
    when 1
      puts "Enter surname:"
      gets.chomp
    when 2
      puts "Enter name:"
      gets.chomp
    when 3
      puts "Enter patronymic:"
      data = gets.chomp
      if data == ""
        nil
      else
        data
      end
    when 4
      puts "Enter birthdate:"
      gets.chomp
    when 5
      Array.new(4) {|el| self.get_data_for_field(el + 1)}
    end
  end

  def get_data(action)
    case action
    when 1
      self.get_data_for_field(5)
    when 3
      puts "Search for:"
      line = gets.chomp
      self.fields_menu
      selected = gets.chomp.split.map {|el| el.to_i}
      [line, selected]
    when 7
      self.fields_menu
      gets.chomp.split.map {|el| el.to_i}[0]
    end
  end

  def select_note
    puts "Select note ID"
    id = gets.chomp.to_i
    @patients_list.set_current
  end

  def fields_menu
    puts "Select fields"
    puts
    puts "1 - Surname"
    puts "2 - Name"
    puts "3 - Patronymic"
    puts "4 - Birthdate"
  end

  def show(message="Patients List", list=nil, limit=10, show_all=false)
    puts message
    puts
    if not list
      list = @patient_list.show
    end
    if show_all
      lim = list.length
    else
      lim = limit < list.length ? limit : list.length
    end
    (0...lim).each { |i|
      puts list[i]
      puts
    }
    puts "#{lim} notes out of #{list.length}"
  end

  def save
    begin
      @patient_list.write
      "Successfully saved"
    rescue
      "An exception occurred. Cannot save file"
    end
  end

end


Patient_List_Terminal_View.new
