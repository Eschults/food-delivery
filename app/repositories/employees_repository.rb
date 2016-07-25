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

  def find_by_index(index)
    delivery_guys[index]
  end

  private

  def resource_class
    Employee
  end
end