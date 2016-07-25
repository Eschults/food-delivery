require "csv"
require_relative "../models/order"
require_relative "base_repository"

class OrdersRepository < BaseRepository
  attr_reader :employees_repository, :customers_repository, :meals_repository

  def initialize(csv_file, employees_repository, customers_repository, meals_repository)
    @employees_repository = employees_repository
    @customers_repository = customers_repository
    @meals_repository = meals_repository
    super(csv_file)
  end

  def mark_order_as_delivered(order)
    order.mark_as_delivered!
    save_to_csv
  end

  def undelivered
    @resources.reject { |order| order.delivered? }
  end

  private

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      if row[:employee_id]
        employee = @employees_repository.find(row[:employee_id].to_i)
        customer = @customers_repository.find(row[:customer_id].to_i)
        meal = @meals_repository.find(row[:meal_id].to_i)
        order = Order.new(id: row[:id].to_i, customer: customer, meal: meal, delivered: row[:delivered] == "true")
        employee.add_order(order) unless order.delivered?
        @resources << order
      else
        @next_id = row[:id].to_i
      end
    end
  end

  def headers
    [ "id", "employee_id", "customer_id", "meal_id", "delivered" ]
  end
end