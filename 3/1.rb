class Employee
  attr_accessor(:employee_name,
                :birthdate,
                :address,
                :passport,
                :speciality,
                :experience,
                :last_job,
                :last_speciality,
                :salary)
	attr_reader :phone, :email, :employee_name

	#--------------------
	#------Override------
	#--------------------

	def initialize(name, bdate, phone, address, email, passport, spec, exp, ljob = nil, lspec = nil, sal = nil)
		@birthdate     = bdate
		@address       = address
		@passport      = passport
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
		name =~ /(([а-я]+)(( *\-+ *)?([а-я]+)?) *){2} *(([а-я]+)( *([а-я]+)?))/i
	end

	#--------------------
	#------Reformat------
	#--------------------

	def reformat_phone(number)
		number.chars.reject! {|el| el =~ /[^\d]/}
		"#{number[0]}-#{number[1..3]}-#{number[4..]}"
	end

	def reformat_name(name)
		words = name.scan(/([а-я]+)|(\-+)/i).flatten.compact.map { |el| el =~ /\-+/ ? "-" : el.capitalize }
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
test.new_person(1)
test.show

