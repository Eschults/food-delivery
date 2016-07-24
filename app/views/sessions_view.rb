require_relative "base_view"

class SessionsView < BaseView
  def welcome_manager(employee)
    puts "Welcome Boss #{employee.user.capitalize}!"
  end

  def welcome_delivery_guy_without_orders(employee)
    puts "Welcome #{employee.user.capitalize}!"
    puts "You have no order yet! Have a coffee :)"
  end

  def welcome_delivery_guy(employee)
    puts "Welcome #{employee.user.capitalize}!"
    puts "You have to deliver the following orders:"
    employee.undelivered_orders.each_with_index do |order, index|
      puts "#{index + 1}. #{order.meal.name.capitalize} to #{order.customer.name.capitalize} at #{order.customer.address}"
    end
  end

  def wrong_credentials
    puts "Wrong credentials, try again!"
  end
end