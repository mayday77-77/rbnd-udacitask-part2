class TodoItem
   include Listable
  attr_reader :description, :due, :priority, :type
  # implement the priority types as a class array for easier scaling and tracking
  @@priority_types = ["high","medium","low"]

  def initialize(description, options={})
    # Added priority check which initializes only if true (accepts valid type or empty?)
    if @@priority_types.include?(options[:priority]) || !options[:priority] 
      @type = "todo"
      @description = description
      @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
      @priority = options[:priority]
    else
      handle_priority_error
    end
  end

  # Required feature to print item type
  def details
    format_description(@description, @type) + "due: " +
    format_date(due_date: @due) +
    format_priority(@priority)
  end

private

  def handle_priority_error
     begin
      raise UdaciListErrors::InvalidPriorityValue, "\nAn Invalid Priority type was entered!"
    rescue Exception => e
      puts e
    end
  end

end