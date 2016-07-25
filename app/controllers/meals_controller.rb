require_relative "../models/meal"
require_relative "../views/meals_view"
require_relative "base_controller"

class MealsController < BaseController
  def create
    name = @resources_view.ask_for("name")
    price = @resources_view.ask_for("price")
    @resources_repository.add(resource_class.new(name: name, price: price))
  end

  private

  def view_class
    MealsView
  end
end