require_relative "../models/meal"
require_relative "../views/meals_view"

class MealsController
  def initialize(meals_repository)
    @meals_repository = meals_repository
    @meals_view = MealsView.new
  end

  def index
    meals = @meals_repository.all
    @meals_view.display(meals)
  end

  def create
    name = @meals_view.ask_for("name")
    price = @meals_view.ask_for("price")
    meal = Meal.new(name: name, price: price)
    @meals_repository.add(meal)
  end
end