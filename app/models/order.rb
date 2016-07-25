class Order
  attr_accessor :id, :delivered, :employee
  attr_reader :employee, :customer, :meal

  def initialize(attributes = {})
    @id = attributes[:id].to_i
    @employee = attributes[:employee]
    @customer = attributes[:customer]
    @meal = attributes[:meal]
    @delivered = attributes[:delivered] == "true" || false
  end

  def delivered?
    @delivered
  end

  def mark_as_delivered!
    @delivered = true
    employee.undelivered_orders.delete(self)
  end

  def to_s
    "#{employee.user.capitalize} must deliver #{meal.name.capitalize} to #{customer.name.capitalize} at #{customer.address}"
  end

  def to_csv_row
    [ @id, @employee.id, @customer.id, @meal.id, @delivered ]
  end
end