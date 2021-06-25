require_relative 'Patient'
require 'json'


class Patient_List
  attr_accessor(:patients,
                :current,
                :filename)

  def initialize
    @filename = "data/patients.json"
    @patients = self.read
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

  def read
    if not File.exist?(@filename)
      Array.new()
    else
      self.from_json(File.read(@filename))
    end
  end

  def write
    File.write(@filename, self.to_json)
  end

  def add(data)
    begin
      id = @patients.length == 0 ? 1 : @patients.max {|el| el.id}.id + 1
      @patients.append(Patient.new(*data))
      @patients[-1].id = id
    rescue
      self.write
      raise "An exception occurred. Your progress was saved"
    end
  end

  def edit(surname=nil, name=nil, patronymic=nil, birthdate=nil)
    begin
      if surname
        self.find_by(0, @current).surname = surname
      end
      if name
        self.find_by(0, @current).surname = name
      end
      if patronymic
        self.find_by(0, @current).surname = patronymic
      end
      if birthdate
        self.find_by(0, @current).surname = birthdate
      end
    rescue
    end
  end

  def delete
    @patients.delete(self.find_by(0, @current))
  end

  def sort_by(field)
    case field
    when 0
      @patients.sort {|el| el.id}
    when 1
      @patients.sort {|el| el.surname}
    when 2
      @patients.sort {|el| el.name}
    when 3
      @patients.sort {|el| el.patronymic}
    when 4
      @patients.sort {|el| el.birthdate}
    end
  end

  def find_by(field, data)
    case field
    when 0
      @patients.find {|el| el.id = data}
    when 1
      @patients.find_all {|el| el.surname = data}
    when 2
      @patients.find_all {|el| el.name = data}
    when 3
      @patients.find_all {|el| el.patronymic = data}
    when 4
      @patients.find_all {|el| el.birthdate = data}
    end
  end

end
