require "csv"
require_relative "../models/customer"
require_relative "base_repository"

class CustomersRepository < BaseRepository

  private

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      if row[:name]
        @resources << Customer.new(id: row[:id].to_i, name: row[:name], address: row[:address])
      else
        @next_id = row[:id].to_i
      end
    end
  end

  def headers
    [ "id", "name", "address" ]
  end
end