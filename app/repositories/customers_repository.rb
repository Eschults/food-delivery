require "csv"
require_relative "../models/customer"

class CustomersRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @customers = []
    @next_id = 1
    load_csv
  end

  def add(customer)
    customer.id = @next_id
    @customers << customer
    @next_id += 1
    save_to_csv
  end

  def find(id)
    @customers.find { |customer| id == customer.id }
  end

  def find_by_index(index)
    @customers[index]
  end

  def all
    @customers
  end

  private

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      if row[:name]
        @customers << Customer.new(id: row[:id].to_i, name: row[:name], address: row[:address])
      else
        @next_id = row[:id].to_i
      end
    end
  end

  def save_to_csv
    CSV.open(@csv_file, "w") do |csv|
      csv << [ "id", "name", "address" ]
      @customers.each do |customer|
        csv << [ customer.id, customer.name, customer.address ]
      end
      csv << [@next_id]
    end
  end
end