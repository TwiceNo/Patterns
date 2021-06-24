class Patient
  attr_accessor(:surname,
                :name,
                :patronymic,
                :birthdate)

  def initialize(surname, name, patronymic = nil, birthdate)
    self.surname = surname
    self.name = name
    if patronymic
      self.patronymic = patronymic
    end
    self.birthdate = birthdate
  end

  def to_s
    line = "Surname: #{self.surname}\n" +
      "Name: #{self.name}\n"
    if @patronymic
      line += "Patronymic: #{self.patronymic}\n"
    end
    line += "Birthdate: #{self.birthdate}\n"
    line
  end

  def self.surname=(surname)
    if surname =~ /[а-я]+( *\- *[а-я]+)?"/i
      @surname = self.reformat(surname)
    else
      raise "Invalid surname"
    end
  end

  def self.name=(name)
    if name =~ /[а-я]+( *\- *[а-я]+)?"/i
      @name = self.reformat(name)
    else
      raise "Invalid name"
    end
  end

  def self.patronymic=(patronymic)
    if patronymic =~ /[а-я]+( *[а-я]+)?"/i
      @patronymic = self.reformat(patronymic)
    else
      raise "Invalid patronymic"
    end
  end

  def self.birthdate=(date)
    if date =~ /^((0?\d)|([1-2]\d)|(3[0-1]))\.((0?[1-9])|(1[0-2]))\.(([1-2]\d)?\d{2})/
      @birthdate = self.reformat_date(date)
    else
      raise "Invalid date"
    end
  end

  def self.reformat(line)
    line = line.scan(/([а-я]+)|(\-+)/i).flatten.compact
    case line.length
    when 1
      line[0].capitalize
    when 2
      line[0].capitalize!
      line.join(" ")
    when 3
      line.map! {|el| el.capitalize}
      line.join
    end
  end

  def self.reformat_date(date)
    date = date.split(".")
    date.map! { |el| el.length == 1 ? "0%s" % [el] : el}
    if date[-1].length == 2
      date[-1] = "19" + date[-1]
    end
    return date.join(".")
  end

end