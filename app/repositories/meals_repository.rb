require "csv"
require_relative "../models/meal"
require_relative "base_repository"

class MealsRepository < BaseRepository

  private

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      if row[:name]
        @resources << Meal.new(id: row[:id].to_i, name: row[:name], price: row[:price].to_i)
      else
        @next_id = row[:id].to_i
      end
    end
  end

  def headers
    [ "id", "name", "price" ]
  end
end