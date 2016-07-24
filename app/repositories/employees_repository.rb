require "csv"
require_relative "../models/employee"

class EmployeesRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @employees = []
    @next_id = 1
    load_csv
  end

  def add(employee)
    employee.id = @next_id
    @employees << employee
    @next_id += 1
    save_to_csv
  end

  def find(id)
    @employees.find { |employee| id == employee.id }
  end

  def find_by_username(username)
    @employees.find { |employee| username == employee.user }
  end

  def find_by_index(index)
    @employees[index]
  end

  def all
    @employees
  end

  private

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      if row[:user]
        @employees << Employee.new(id: row[:id].to_i, user: row[:user], password: row[:password], manager: row[:manager] == "true")
      else
        @next_id = row[:id].to_i
      end
    end
  end

  def save_to_csv
    CSV.open(@csv_file, "w") do |csv|
      csv << [ "id", "user", "password" ]
      @employees.each do |employee|
        csv << [ employee.id, employee.user, employee.password, employee.manager ]
      end
      csv << [@next_id]
    end
  end
end