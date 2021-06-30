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
    puts "4 - Select"
    puts "5 - Save"
    puts "6 - Sort"
    puts "0 - Exit"
  end

  def menu_selected
    puts "Options"
    puts "1 - Edit"
    puts "2 - Delete"
    puts "0 - Discard"
    puts
  end

  def take_action
    action = gets.chomp
    while action != "0"
      puts self.act(action.to_i)
      action = gets.chomp
    end
  end

  def take_action_selected
    action = gets.chomp
    self.act_selected(action.to_i)
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
      if self.select_note
        self.show("Selected", [@patient_list.find_by(0, @patient_list.current)])
        self.menu_selected
        self.take_action_selected
      else
        "Note does not exist"
      end
    when 5
      self.save
    when 6
      field = self.get_data(action)
      self.show("Sorted by field #{field}", @patient_list.sort_by(field))
    else
      "Invalid command"
    end
  end

  def act_selected(action)
    case action
    when 0
      return
    when 1
      self.edit
    when 2
      @patient_list.delete
      puts "Successfully deleted"
    else
      puts "Invalid operation"
    end
  end

  def edit
    self.fields_menu
    selected = gets.chomp.split.map {|el| el.to_i}
    data  = Array.new
    (1..4).each do |el|
      if selected.include? el
        data.append(self.get_data_for_field(el))
      else
        data.append(nil)
      end
    end
    @patient_list.edit(*data)
    self.show("Changed to", [@patient_list.find_by(0, @patient_list.current)])
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
    @patient_list.set_current(id)
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
