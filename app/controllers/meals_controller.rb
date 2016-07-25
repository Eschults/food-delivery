require_relative "../models/meal"
require_relative "../views/meals_view"
require_relative "base_controller"

class MealsController < BaseController

  private

  def view_class
    MealsView
  end

  def resource_class
    Meal
  end
end