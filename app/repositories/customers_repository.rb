require "csv"
require_relative "../models/customer"
require_relative "base_repository"

class CustomersRepository < BaseRepository

  private

  def resource_class
    Customer
  end

  def headers
    [ "id", "name", "address" ]
  end
end