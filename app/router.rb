require_relative 'controllers/meals_controller'
require_relative 'controllers/sessions_controller'
require_relative 'controllers/customers_controller'
require_relative 'controllers/orders_controller'

class Router
  def initialize(meals_controller, sessions_controller, customers_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @orders_controller = orders_controller
    @sessions_controller = sessions_controller
    @current_user = nil
  end

  def run
    puts "Welcome to the Restaurant!"
    puts "           --           "
    @current_user = @sessions_controller.log_in
    while @current_user
      if @current_user.manager?
        display_manager_tasks
        action = gets.chomp.to_i
        print `clear`
        trigger_manager_request(action)
      else
        display_delivery_guy_tasks
        action = gets.chomp.to_i
        print `clear`
        trigger_delivery_guy_request(action)
      end
    end
  end

  def logout!
    @current_user = @sessions_controller.log_in
  end

  def stop!
    @current_user = nil
  end

  private

  def display_manager_tasks
    puts ""
    puts "What do you want to do next?"
    puts "1 - Add a meal"
    puts "2 - List all meals"
    puts "3 - Add a customer"
    puts "4 - List all customers"
    puts "5 - List undelivered orders"
    puts "6 - Create a new order"
    puts "7 - Logout"
    puts "8 - Stop and exit the program"
    print "> "
  end

  def trigger_manager_request(action)
    case action
    when 1 then @meals_controller.create
    when 2 then @meals_controller.index
    when 3 then @customers_controller.create
    when 4 then @customers_controller.index
    when 5 then @orders_controller.list_undelivered
    when 6 then @orders_controller.create
    when 7 then logout!
    when 8 then stop!
    else puts "Please press 1, 2, 3, 4, 5, 6, 7 or 8"
    end
  end

  def display_delivery_guy_tasks
    puts ""
    puts "What do you want to do next?"
    puts "1 - View my undelivered orders"
    puts "2 - Mark order as delivered"
    puts "3 - Logout"
    puts "4 - Stop and exit the program"
    print "> "
  end

  def trigger_delivery_guy_request(action)
    case action
    when 1 then @orders_controller.list_my_undelivered
    when 2 then @orders_controller.mark_as_delivered
    when 3 then logout!
    when 4 then stop!
    else puts "Please press 1, 2, 3 or 4"
    end
  end
end
