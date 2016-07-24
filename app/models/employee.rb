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
end