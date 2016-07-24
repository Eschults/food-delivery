require "csv"
require_relative "../models/meal"

class MealsRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @meals = []
    @next_id = 1
    load_csv
  end

  def add(meal)
    meal.id = @next_id
    @meals << meal
    @next_id += 1
    save_to_csv
  end

  def find(id)
    @meals.find { |meal| id == meal.id }
  end

  def find_by_index(index)
    @meals[index]
  end

  def all
    @meals
  end

  private

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      if row[:name]
        @meals << Meal.new(id: row[:id].to_i, name: row[:name], price: row[:price].to_i)
      else
        @next_id = row[:id].to_i
      end
    end
  end

  def save_to_csv
    CSV.open(@csv_file, "w") do |csv|
      csv << [ "id", "name", "price" ]
      @meals.each do |meal|
        csv << [ meal.id, meal.name, meal.price ]
      end
      csv << [@next_id]
    end
  end
end