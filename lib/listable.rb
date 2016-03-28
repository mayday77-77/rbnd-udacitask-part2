module Listable
  # Listable methods go here
  def format_description(description)
    "#{description}".ljust(30)
  end

  # refactor format_date
  def format_date(options = {})
    if options[:start_date] || options[:end_date]
      dates = options[:start_date].strftime("%D") if options[:start_date]
      dates << " -- " + options[:end_date].strftime("%D") if options[:end_date]
      dates = "N/A" if !dates
      return dates
    else
  	 options[:due_date] ? options[:due_date].strftime("%D") : "No due date"
  end
  
  end

  #refactor format_priority
  def format_priority(input_priority)
    value = " ⇧" if input_priority == "high"
    value = " ⇨" if input_priority == "medium"
    value = " ⇩" if input_priority == "low"
    value = "" if !input_priority
    return value
  end

end
