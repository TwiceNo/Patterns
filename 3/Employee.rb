class Employee
  attr_accessor(:address,
                :speciality,
                :experience,
                :last_job,
                :last_speciality,
                :salary)
  attr_reader(:phone,
              :email,
              :name,
              :passport,
              :birthdate)

  def initialize(name,
                 birthdate,
                 phone,
                 address,
                 email,
                 passport,
                 spec,
                 exp,
                 last_job = nil,
                 last_speciality = nil,
                 sal = nil)
    @address       = address
    @speciality    = spec
    @experience    = exp
    if exp > 0
      @last_job = last_job
      @last_speciality = last_speciality
      @salary = sal
    end
    self.phone = phone
    self.email = email
    self.name = name
    self.birthdate = birthdate
    self.passport = passport
  end

  def to_s
    [@name,
     @birthdate,
     @phone,
     @address,
     @email,
     @passport,
     @speciality,
     @experience,
     @last_job,
     @last_speciality,
     @salary].compact.join("\n")
  end

  # ----------------
  # ----Setters-----
  # ----------------

  def self.name= (name)
    if name =~ /^(([а-яё]+)(( *\-+ *)?([а-яё]+)?) *){2} *(([а-яё]+)( *([а-яё]+)?))/i
      @name = self.reformat_name(name)
    else
      raise "Invalid name"
    end
  end

  def self.phone= (phone)
    if phone =~ /^(8|\+?7)( ?\-?\(?\d{3} ?\)?\-?)(\-? ?(\d{7}|(\d{3})(\-? ?\d{2}){2}))/
      @phone = self.reformat_phone(phone)
    else
      raise "Invalid phone"
    end
  end

  def self.email= (email)
    if email =~ /^.+@.+\..+/i
      @email = self.reformat_email(email)
    else
      raise "Invalid email"
    end
  end

  def self.birthdate= (date)
    if date =~ /^((0?\d)|([1-2]\d)|(3[0-1]))\.((0?[1-9])|(1[0-2]))\.(([1-2]\d)?\d{2})/
      @birthdate = self.reformat_birthdate(date)
    else
      raise "Invalid date"
    end
  end

  def self.passport= (passport)
    if passport =~ /^\d{4} *\d{6}/
      @passport = self.reformat_passport(passport)
    else
      raise "Invalid passport"
    end
  end

  # ----------------
  # ----Reformat----
  # ----------------

  def self.reformat_birthdate(date)
    date = date.split(".")
    date.map! { |el| el.length == 1 ? "0%s" % [el] : el}
    if date[-1].length == 2
      date[-1] = "19" + date[-1]
    end
    return date.join(".")
  end

  def self.reformat_name(name)
    words = name.scan(/([а-яё]+)|(\-+)/i).flatten.compact.map { |el| el =~ /\-+/ ? "-" : el.capitalize }
    indices = words.map.with_index { |el, i| i if el == "-" }.compact
    indices.each do |index|
      words[index - 1] = words[index - 1 .. index + 1].join()
      words[index] = nil
      words[index + 1] = nil
    end
    words.compact!
    if words.length == 4
      words[-1].downcase!
    end
    return words.join(" ")
  end

  def self.reformat_passport(passport)
    passport = passport.chars
    passport.reject! { |el| el == " " }
    [passport[0...4].join(), passport[4..].join()].join(" ")
  end

  def self.reformat_phone(phone)
    number = phone.chars
    number.reject! {|el| el =~ /[^\d]/}
    number.compact!
    "#{number[0]}-#{number[1..3].join()}-#{number[4..].join()}"
  end

  def self.reformat_email(email)
    email.downcase
  end

end
