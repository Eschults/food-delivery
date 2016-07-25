require_relative '../views/orders_view'

class OrdersController
  def initialize(orders_repository, sessions_controller)
    @orders_repository = orders_repository
    @meals_repository = @orders_repository.meals_repository
    @customers_repository = @orders_repository.customers_repository
    @employees_repository = @orders_repository.employees_repository
    @sessions_controller = sessions_controller
    @orders_view = OrdersView.new
  end

  def create
    meal = display_and_select("meal", @meals_repository)
    customer = display_and_select("customer", @customers_repository)
    employee = display_and_select("employee", @employees_repository)

    order = Order.new(meal: meal, customer: customer)
    employee.add_order(order)
    @orders_repository.add(order)
  end

  def list_undelivered
    binding.pry
    undelivered_orders = @orders_repository.undelivered
    @orders_view.display(undelivered_orders)
  end

  def list_my_undelivered
    print_current_user_undelivered_orders
  end

  def mark_as_delivered
    print_current_user_undelivered_orders
    order = nil
    until order
      delivered_order_index = @orders_view.ask_for_index_of("order")
      order = @current_user.undelivered_orders[delivered_order_index]
    end
    @orders_repository.mark_order_as_delivered(order)
  end

  private

  def display_and_select(resource_name, resource_repo)
    if resource_name == "employee"
      resources = resource_repo.delivery_guys
    else
      resources = resource_repo.all
    end
    @orders_view.display(resources)
    resource_found = nil
    until resource_found
      resource_index = @orders_view.ask_for_index_of(resource_name)
      resource_found = resource_repo.find_by_index(resource_index)
    end
    return resource_found
  end

  def print_current_user_undelivered_orders
    @current_user = @sessions_controller.current_user
    current_user_undelivered_orders = @current_user.undelivered_orders
    @orders_view.display(current_user_undelivered_orders)
  end
end
