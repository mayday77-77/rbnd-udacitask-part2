class TodoItem
   include Listable
  attr_reader :description, :due, :priority

  def initialize(description, options={})
    # Added priority check which initializes only if true
    if priority_check(options[:priority])
      @description = description
      @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
      @priority = options[:priority]
    end
  end

  def details
    format_description(@description) + "due: " +
    format_date(due_date: @due) +
    format_priority(@priority)
  end

  def priority_check(input_priority)
    # reuse format_priority to check for the input of priority
    if format_priority(input_priority) == "exception"
      handle_priority_error
      return false
    else
      return true
    end
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