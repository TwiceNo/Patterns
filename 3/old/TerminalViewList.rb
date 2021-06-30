class TerminalViewListEmployee
  attr_accessor (:employee_list)

  def initialize
    @employee_list = Array.new()
  end

  def show
    @employee_list.each do |elem|
      puts elem.to_s
      puts
    end
  end

  def add

  end
end
