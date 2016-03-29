module Listable
  # Listable methods go here

  # Required feature to include type
  def format_description(description, type)
    "#{description} [#{type}]".ljust(40)
  end

  # refactor format_date to accept different number of arguments
  def format_date(options = {})
    if options[:start_date] || options[:end_date] || options[:type]
      dates = options[:start_date].strftime("%D") if options[:start_date]
      dates << " -- " + options[:end_date].strftime("%D") if options[:end_date]
      dates = "N/A" if !dates
      return dates
    else
  	 options[:due_date] ? options[:due_date].strftime("%D") : "No due date"
  end
  
  end

  # refactor format_priority with switch/case
  def format_priority(input_priority)
    case input_priority
      when "high"; value = " ⇧".colorize(:red)
      when "medium"; value = " ⇨".colorize(:green)
      when "low"; value = " ⇩".colorize(:blue)
      else value = ""
    end
    return value
  end

  # Differentiate colors for different item types grep(reg exp) for beautifying table
  def format_beautify(input_details)
  	puts input_details
  	input_details.lines.grep(/"\[todo\]"/) ? (puts "yes") : (puts "no")
  	#color = "red" if input_details.lines.grep(/[event]/)
  	return input_details.colorize(:blue)
  end

end
