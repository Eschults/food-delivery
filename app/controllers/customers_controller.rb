require_relative "../models/customer"
require_relative "../views/customers_view"
require_relative "base_controller"

class CustomersController < BaseController

  private

  def view_class
    CustomersView
  end

  def resource_class
    Customer
  end
end