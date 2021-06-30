class TestEmployee
  attr_accessor :employee_list

  def initialize
    @employee_list = Array.new
  end

  def new_person(amount)
    amount.times do
      @employee_list.append (Employee.new(*generate_person()))
    end
  end

  def add_person(amount)
    amount.times do
      @employee_list.append (Employee.new(*enter_person()))
    end
  end

  def enter_person
    Array.new(11) { STDIN.gets.chomp }
  end

  def show
    @employee_list.each do |elem|
      puts elem.to_s
      puts
    end
  end
end


