require "csv"
require_relative "../models/order"

class OrdersRepository
  attr_reader :employees_repository, :customers_repository, :meals_repository

  def initialize(csv_file, employees_repository, customers_repository, meals_repository)
    @csv_file = csv_file
    @employees_repository = employees_repository
    @customers_repository = customers_repository
    @meals_repository = meals_repository
    @orders = []
    @next_id = 1
    load_csv
  end

  def mark_order_as_delivered(order)
    order.mark_as_delivered!
    save_to_csv
  end

  def add(order)
    order.id = @next_id
    @orders << order
    @next_id += 1
    save_to_csv
  end

  def find(id)
    @orders.find { |order| id == order.id }
  end

  def find_by_index(index)
    @orders[index]
  end

  def all
    @orders
  end

  def undelivered
    @orders.reject { |order| order.delivered }
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
        @orders << order
      else
        @next_id = row[:id].to_i
      end
    end
  end

  def save_to_csv
    binding.pry
    CSV.open(@csv_file, "w") do |csv|
      csv << [ "id", "employee_id", "customer_id", "meal_id", "delivered" ]
      @orders.each do |order|
        csv << [ order.id, order.employee.id, order.customer.id, order.meal.id, order.delivered ]
      end
      csv << [@next_id]
    end
  end
end