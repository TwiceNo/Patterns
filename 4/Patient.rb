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
    line += "Birthdate: #{self.birthdate}\n\n"
    line
  end


  def self.surname=(surname)
    @surname = self.surname_set(surname)
  end

  def surname=(surname)
    @surname = self.class.surname_set(surname)
  end

  def self.surname_set(surname)
    if surname =~ /^ *[а-я]+( *\- *[а-я]+)? *$/i
      self.reformat(surname)
    else
      raise "Invalid surname"
    end
  end


  def self.name=(name)
    @name = self.name_set(name)
  end

  def name=(name)
    @name = self.class.name_set(name)
  end

  def self.name_set(name)
    if name =~ /^ *[а-я]+( *\- *[а-я]+)? *$/i
      self.reformat(name)
    else
      raise "Invalid name"
    end
  end


  def self.patronymic=(patronymic)
    @patronymic = self.patronymic_set(patronymic)
  end

  def patronymic=(patronymic)
    @patronymic = self.class.patronymic_set(patronymic)
  end

  def self.patronymic_set(patronymic)
    if patronymic =~ /^ *[а-я]+( *[а-я]+)? *$/i
      self.reformat(patronymic)
    else
      raise "Invalid patronymic"
    end
  end


  def self.birthdate=(date)
    @birthdate = self.birthdate_set(date)
  end

  def birthdate=(date)
    @birthdate = self.class.birthdate_set(date)
  end

  def self.birthdate_set(date)
    if date =~ /^ *((0?\d)|([1-2]\d)|(3[0-1]))\.((0?[1-9])|(1[0-2]))\.(([1-2]\d)?\d{2}) *$/
      self.reformat_date(date)
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
    date.join(".")
  end

end