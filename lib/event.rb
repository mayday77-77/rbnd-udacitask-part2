class EventItem
   include Listable
  attr_reader :description, :start_date, :end_date, :type

  def initialize(description, options={})
    @type = "event"
    @description = description
    @start_date = Date.parse(options[:start_date]) if options[:start_date]
    @end_date = Date.parse(options[:end_date]) if options[:end_date]
  end

  # Required feature to print item type
  def details
    format_description(@description, @type) + "event dates: " + format_date(start_date: @start_date, end_date: @end_date, type: @type)
  end
end
