require_relative 'Patient'
require_relative 'DB_Connection'
require 'json'
require 'date'


class Patient_List
  attr_accessor(:patients,
                :current,
                :filename)

  def initialize
    @filename = "data/patients.json"
    @patients = self.read_from_json
    begin
      @db_connection = DB_Connection.get_instance
    rescue
    end
  end

  def connected
    if @db_connection
      true
    else
      false
    end
  end

  def to_json
    {"@patients" => @patients.map{|el| el.to_json}}.to_json
  end

  def from_json(json_string)
    JSON.load(json_string).each do |var, val|
      self.instance_variable_set var, val
    end
    @patients.map! {|el| Patient.from_json(el)}
  end

  def length
    @patients.length
  end

  def check_difference
    database = self.read_from_database.map {|el| el.to_s}
    json = @patients.map {|el| el.to_s}
    json_difference = json - database
    database_difference = database - json
    if json_difference or database_difference
      [json_difference.length, database_difference.length]
    end
  end

  def set_source(source)
    if source == 2
      @patients = self.read_from_database
    else
      self.alter_database
    end
  end

  def alter_database
    @db_connection.delete_all
    @patients.each do |el|
      @db_connection.add_patient(el, true)
    end
  end

  def read_from_database
    result = @db_connection.read_patients
    list = Array.new()
    if result
      result.each do |el|
        list.append(Patient.from_database(el))
      end
    end
    list
  end

  def read_from_json
    if not File.exist?(@filename)
      Array.new()
    else
      self.from_json(File.read(@filename))
    end
  end

  def write
    File.write(@filename, self.to_json)
  end

  def set_current(id)
    if self.find_by(0, id)
      @current = id
    end
  end

  def add(data)
    begin
      inst = Patient.new(*data)
      if @db_connection
        @db_connection.add_patient(inst)
        inst.id = @db_connection.get_id
      else
        inst.id = @patients.length == 0 ? 1 : @patients.max {|el| el.id}.id + 1
      end
      @patients.append(inst)
    rescue
      self.write
      raise "An exception occurred"
    end
  end

  def edit(surname=nil, name=nil, patronymic=nil, birthdate=nil)
    begin
      if surname
        self.find_by(0, @current).surname = surname
        if @db_connection
          @db_connection.edit_patient(@current, "surname", self.find_by(0, @current).surname)
        end
      end
      if name
        self.find_by(0, @current).name = name
        if @db_connection
          @db_connection.edit_patient(@current, "name", self.find_by(0, @current).name)
        end
      end
      if patronymic
        self.find_by(0, @current).patronymic = patronymic
        if @db_connection
          @db_connection.edit_patient(@current, "patronymic", self.find_by(0, @current).patronymic)
        end
      end
      if birthdate
        self.find_by(0, @current).birthdate = birthdate
        if @db_connection
          @db_connection.edit_patient(@current, "birthdate", Date.parse(self.find_by(0, @current).birthdate))
        end
      end
    rescue
    end
  end

  def delete
    @patients.delete(self.find_by(0, @current))
    if @db_connection
      @db_connection.delete_patient(@current)
    end
  end

  def show
    @patients
  end

  def sort_by(field)
    case field
    when 0
      @patients.sort_by {|el| el.id}
    when 1
      @patients.sort_by {|el| el.surname}
    when 2
      @patients.sort_by {|el| el.name}
    when 3
      list = @patients.select {|el| el.patronymic != nil}
      list.sort_by {|el| el.patronymic}
    when 4
      @patients.sort_by {|el| DateTime.parse(el.birthdate)}
    end
  end

  def find_by(field, data)
    case field
    when 0
      @patients.find {|el| el.id == data}
    when 1
      @patients.find_all {|el| el.surname.downcase.include?data.downcase}
    when 2
      @patients.find_all {|el| el.name.downcase.include?data.downcase}
    when 3
      @patients.find_all {|el| el.patronymic and el.patronymic.downcase.include?data.downcase}
    when 4
      @patients.find_all {|el| el.birthdate.downcase.include?data.downcase}
    end
  end

end

# list = Patient_List.new
# p list.find_by(0, 20)
