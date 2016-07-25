require_relative "../models/customer"
require_relative "../views/customers_view"
require_relative "base_controller"

class CustomersController < BaseController
  def create
    name = @resources_view.ask_for("name")
    address = @resources_view.ask_for("address")
    @resources_repository.add(Customer.new(name: name, address: address))
  end

  private

  def view_class
    CustomersView
  end
end