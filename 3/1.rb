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
end