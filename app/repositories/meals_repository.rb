require "csv"
require_relative "../models/meal"
require_relative "base_repository"

class MealsRepository < BaseRepository

  private

  def resource_class
    Meal
  end

  def headers
    [ "id", "name", "price" ]
  end
end