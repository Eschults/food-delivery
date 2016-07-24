require "csv"
require_relative "../models/employee"
require_relative "base_repository"

class EmployeesRepository < BaseRepository
  def find_by_username(username)
    @resources.find { |employee| employee.user == username }
  end

  def delivery_guys
    @resources.reject { |employee| employee.manager? }
  end

  private

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      if row[:user]
        @resources << Employee.new(id: row[:id].to_i, user: row[:user], password: row[:password], manager: row[:manager] == "true")
      else
        @next_id = row[:id].to_i
      end
    end
  end
end