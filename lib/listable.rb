module Listable
  # Listable methods go here
  def format_description(description)
    "#{description}".ljust(30)
  end

  # refactor format_date
  def format_date(first_date, options = {})
  	puts options.class
  	first_date ? first_date.strftime("%D") : "No due date"
#  	dates = @start_date.strftime("%D") if @start_date
 #   dates << " -- " + @end_date.strftime("%D") if @end_date
  #  dates = "N/A" if !dates
   # return dates
  
  end

  #refactor format_priority
  def format_priority

  end

end
