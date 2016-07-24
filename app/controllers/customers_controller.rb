require_relative "../views/customers_view"

class CustomersController
  def initialize(customers_repository)
    @customers_repository = customers_repository
    @customers_view = CustomersView.new
  end

  def create
    name = @customers_view.ask_for("name")
    address = @customers_view.ask_for("address")
    @customers_repository.add(Customer.new(name: name, address: address))
  end

  def index
    customers = @customers_repository.all
    @customers_view.display(customers)
  end
end