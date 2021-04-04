class Employee
  attr_accessor(:employee_name,
                :birthdate,
                :address,
                :email,
                :passport,
                :speciality,
                :experience,
                :last_job,
                :last_speciality,
                :salary)
	attr_reader :phone

	#--------------------
	#------Override------
	#--------------------

	def initialize(name, bdate, phone, address, email, passport, spec, exp, ljob = nil, lspec = nil, sal = nil)
		@employee_name = name
		@birthdate     = bdate
		@address       = address
		@email         = email
		@passport      = passport
		@speciality    = spec
		@experience    = exp
		if exp > 0
			@last_job = ljob
			@last_speciality = lspec
			@salary = sal
		end
		self.phone = phone
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
		end
	end

	#--------------------
	#------Setters-------
	#--------------------

	def phone= (number)
		if phone_validation(number)
			@phone = self.reformat(number)
		else
			self.exception(1)
		end
	end


	#--------------------
	#-----Validation-----
	#--------------------

	def phone_validation(phone_number)
		phone_number =~ /(8|\+?7)( ?\-?\(?\d{3} ?\)?\-?)(\-? ?(\d{7}|(\d{3})(\-? ?\d{2}){2}))/
	end

	def reformat(number)
		number.chars.reject! {|el| el =~ /[^\d]/}
		"#{number[0]}-#{number[1..3]}-#{number[4..]}"
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

	def show
		@employee_list.each do |elem|
			puts elem.to_s
			puts
			end
	end
end



require_relative 'generate_person'
test = TestEmployee.new
test.new_person(10)
test.show

