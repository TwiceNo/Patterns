require 'mysql'
require "date"

class DB_Connection
  @@instance = nil

  def initialize
    @connection = Mysql.new("127.0.0.1", "root")
    @connection.select_db("hospital")
  end

  def self.get_instance
    if not @@instance
      @@instance = DB_Connection.new
    end
    @@instance
  end

  def read_table(table)
    @connection.query("select * from #{table}")
  end

  def add_patient(item, force=false)
    if force
      if item.patronymic
        query = "insert into patients (id, surname, name, patronymic, birthdate)
               values (#{item.id}, '#{item.surname}', '#{item.name}', '#{item.patronymic}', '#{Date.parse(item.birthdate)}')"
      else
        query = "insert into patients (id, surname, name, birthdate)
               values (#{item.id}, '#{item.surname}', '#{item.name}', '#{Date.parse(item.birthdate)}')"
      end
    else
      if item.patronymic
        query = "insert into patients (surname, name, patronymic, birthdate)
               values ('#{item.surname}', '#{item.name}', '#{item.patronymic}', '#{Date.parse(item.birthdate)}')"
      else
        query = "insert into patients (surname, name, birthdate)
               values ('#{item.surname}', '#{item.name}', '#{Date.parse(item.birthdate)}')"
      end
    end
    @connection.query(query)
    @connection.commit
  end

  def edit_table(id, field, value, table)
    @connection.query("update #{table} set #{field} = '#{value}' where id = #{id}")
    @connection.commit
  end

  def delete_from(id, table)
    @connection.query("delete from #{table} where id = #{id}")
    @connection.commit
  end

  def delete_all(table)
    @connection.query("delete from #{table} where 1")
    @connection.commit
  end

  def get_id(table)
    @connection.query("select max(id) from #{table}").each do |el|
      return el[0].to_i
    end
  end

end
