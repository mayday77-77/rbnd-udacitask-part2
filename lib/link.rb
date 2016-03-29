class LinkItem
   include Listable
  attr_reader :description, :site_name, :type

  def initialize(url, options={})
    @type = "link"
    @description = url
    @site_name = options[:site_name] || "No site name" # Assign N/A as default with no value passed in
  end
  
  def format_name
    @site_name ? @site_name : ""
  end

  # Required feature to print item type
  def details
    format_description(@description, @type) + "site name: " + format_name
  end
end
