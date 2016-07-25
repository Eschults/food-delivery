class BaseView
  def display(resources)
    resources.each_with_index do |resource, index|
      puts "#{index + 1}. #{resource.to_s}"
    end
  end

  def ask_for_index_of(topic)
    puts "Which #{topic} index?"
    print "> "
    gets.chomp.to_i - 1
  end

  def ask_for(something)
    puts "Enter #{something}:"
    print "> "
    return gets.chomp
  end
end