class Employee
  attr_accessor :id
  attr_reader :user, :password, :manager, :undelivered_orders

  def initialize(attributes = {})
    @id = attributes[:id]
    @user = attributes[:user]
    @password = attributes[:password]
    @manager = attributes[:manager]
    @undelivered_orders = []
  end

  def manager?
    @manager
  end

  def add_order(order)
    @undelivered_orders << order
    order.employee = self
  end

  def to_s
    "#{user.capitalize} (#{undelivered_orders_count_to_s})"
  end

  def undelivered_orders_count
    @undelivered_orders.count
  end

  def undelivered_orders?
    undelivered_orders_count > 0
  end

  def undelivered_orders_count_to_s
    if undelivered_orders?
      "#{undelivered_orders_count} undelivered order(s)"
    else
      "available"
    end
  end
end