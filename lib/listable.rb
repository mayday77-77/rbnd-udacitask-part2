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

  # refactor format_priority with switch/case
  # added invalid priority input(not nil and not in the list below)
  def format_priority(input_priority)
    case input_priority
      when "high"; value = " ⇧"
      when "medium"; value = " ⇨"
      when "low"; value = " ⇩"
      else value = ""
    end
    return value
  end

end
