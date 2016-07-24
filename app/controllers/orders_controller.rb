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

  def list_undelivered
    undelivered_orders = @orders_repository.undelivered
    @orders_view.display(undelivered_orders)
  end

  def create
    meals = @meals_repository.all
    @orders_view.display(meals)
    meal = nil
    until meal
      meal_index = @orders_view.ask_for_index_of("meal")
      meal = @meals_repository.find_by_index(meal_index)
    end

    customers = @customers_repository.all
    @orders_view.display(customers)
    customer = nil
    until customer
      customer_index = @orders_view.ask_for_index_of("customer")
      customer = @customers_repository.find_by_index(customer_index)
    end

    employees = @employees_repository.all
    @orders_view.display(employees)
    employee = nil
    until employee
      employee_index = @orders_view.ask_for_index_of("employee")
      employee = @employees_repository.find_by_index(employee_index)
    end

    order = Order.new(meal: meal, customer: customer)
    employee.add_order(order)
    @orders_repository.add(order)
  end

  def list_my_undelivered
    print_current_user_undelivered_orders
  end

  def mark_as_delivered
    print_current_user_undelivered_orders
    order = nil
    until order
      delivered_order_index = @orders_view.ask_for_index_of("order")
      order = @orders_repository.find_by_index(delivered_order_index)
    end
    @orders_repository.mark_order_as_delivered(order)
  end

  private

  def print_current_user_undelivered_orders
    @current_user = @sessions_controller.current_user
    current_user_undelivered_orders = @current_user.undelivered_orders
    @orders_view.display(current_user_undelivered_orders)
  end
end
