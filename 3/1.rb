class Employee
  attr_accessor(:employee_name,
                :birthdate,
                :phone,
                :address,
                :email,
                :passport,
                :speciality,
                :experience,
                :last_job,
                :last_speciality,
                :salary)

	def initialize(name, bdate, phone, address,
								 email, passport, spec, exp,
								 ljob = nil, lspec = nil, sal = nil)
		@employee_name = name
		@birthdate     = bdate
		@phone         = phone
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
	end

	def to_s
		string = "ФИО:	             #{@employee_name}
Дата рождения:       #{@birthdate }
Телефон:             #{@phone     }
Адрес:               #{@address   }
Почта:               #{@email     }
Паспорт серия номер: #{@passport  }
Специальность:       #{@speciality}
Стаж:                #{@experience}
"
		if @experience > 0
			string += "Предыдущее место работы: #{@last_job}
Должность:   		 #{@last_speciality}
Зарплата:    		 #{@salary}"
		end
		string
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
