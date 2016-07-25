class BaseController
  def initialize(resources_repository)
    @resources_repository = resources_repository
    @resources_view = view_class.new
  end

  def index
    resources = @resources_repository.all
    @resources_view.display(resources)
  end

  def create
    name = @resources_view.ask_for("name")
    price = @resources_view.ask_for("price") if resource_class == Meal
    address = @resources_view.ask_for("address") if resource_class == Customer
    @resources_repository.add(resource_class.new(name: name, price: price, address: address))
  end
end