class Employee
  attr_accessor(:address,
                :speciality,
                :experience,
                :last_job,
                :last_speciality,
                :salary)
	attr_reader :phone, :email, :employee_name, :birthdate, :passport

	#--------------------
	#------Override------
	#--------------------

	def initialize(name, bdate, phone, address, email, passport, spec, exp, ljob = nil, lspec = nil, sal = nil)
		@address       = address
		@speciality    = spec
		@experience    = exp
		if exp > 0
			@last_job = ljob
			@last_speciality = lspec
			@salary = sal
		end
		self.phone = phone
		self.email = email
		self.employee_name = name
		self.birthdate = bdate
		self.passport = passport
	end


	def to_s
		[@employee_name,
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

	def exception(error)
		case error
		when 1
			puts "Invalid phone number"
		when 2
			puts "Invalid email"
		when 3
			puts "Invalid name"
		when 4
			puts "Invalid date"
		when 5
			puts "Invalid passport"
		end
	end

	#--------------------
	#------Setters-------
	#--------------------

	def phone= (number)
		if phone_validation(number)
			@phone = self.reformat_phone(number)
		else
			self.exception(1)
		end
	end

	def email= (email)
		if email_validation(email)
			@email = email.downcase
		else
			self.exception(2)
		end
	end

	def employee_name= (name)
		if name_validation(name)
			@employee_name = reformat_name(name)
		else
			self.exception(3)
		end
	end

	def birthdate= (date)
		if date_validation(date)
			@birthdate = reformat_date(date)
		else
			self.exception(4)
		end
 end

	def passport= (passport)
		if passport_validation(passport)
			@passport = reformat_passport(passport.chars)
		else
			self.exception(5)
		end
	end


	#--------------------
	#-----Validation-----
	#--------------------

	def phone_validation(phone_number)
		phone_number =~ /(8|\+?7)( ?\-?\(?\d{3} ?\)?\-?)(\-? ?(\d{7}|(\d{3})(\-? ?\d{2}){2}))/
	end

	def email_validation(email)
		email =~ /.+@.+\..+/i
	end

	def name_validation(name)
		name =~ /(([а-яё]+)(( *\-+ *)?([а-яё]+)?) *){2} *(([а-яё]+)( *([а-яё]+)?))/i
	end

	def date_validation(date)
		date =~ /((0?[1-9])|([1-2][0-9])|(3[0-1]))\.((0?[1-9])|(1[0-2]))\.(([1-2][0-9])?[0-9]{2})/
	end

	def passport_validation(passport)
		passport =~ /([0-9]{2} *){2} +[0-9]{6}/
	end


	#--------------------
	#------Reformat------
	#--------------------

	def reformat_phone(number)
		number.chars.reject! {|el| el =~ /[^\d]/}
		"#{number[0]}-#{number[1..3]}-#{number[4..]}"
	end

	def reformat_name(name)
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
		words.join(" ")
	end

	def reformat_date(date)
		date = date.split(".")
		date.map! { |el| el.length == 1 ? "0%s" % [el] : el}
		if date[-1].length == 2
			date[-1] = "19" + date[-1]
		end
		date.join(".")
	end

	def reformat_passport(passport)
		passport.reject! { |el| el == " " }
		[passport[0...4].join(), passport[4..].join()].join(" ")
	end

end


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



require_relative 'generate_person'
test = TestEmployee.new
test.new_person(32)
test.show

