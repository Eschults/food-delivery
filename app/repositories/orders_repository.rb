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
    @resources.reject { |order| order.delivered }
  end

  private

  def resource_class
    Order
  end

  def headers
    [ "id", "employee_id", "customer_id", "meal_id", "delivered" ]
  end
end