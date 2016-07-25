class BaseRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @resources = []
    @next_id = 1
    load_csv
  end

  def add(resource)
    resource.id = @next_id
    @resources << resource
    @next_id += 1
    save_to_csv
  end

  def find(id)
    @resources.find { |resource| id == resource.id }
  end

  def find_by_index(index)
    @resources[index]
  end

  def all
    @resources
  end

  private

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      if row[:name] || row[:user]
        @resources << resource_class.new(row)
      else
        @next_id = row[:id].to_i
      end
    end
  end

  def save_to_csv
    CSV.open(@csv_file, "w") do |csv|
      csv << headers
      @resources.each do |resource|
        csv << resource.to_csv_row
      end
      csv << [@next_id]
    end
  end
end