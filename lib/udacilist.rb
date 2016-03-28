class UdaciList

  attr_reader :title, :items
  # implement the item types as a class array for easier scaling and tracking
  @@item_types = ["todo","event","link"]

  def initialize(options={})
    # Added default title if none given
    @title = options[:title] || "Untitled List"
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase
    # Added item type check which initializes only if true
    if @@item_types.include?(type)
      # Stop the push to the items array if initialization for Todo fails because of invalid priority
      @items.push TodoItem.new(description, options) if type == "todo" 
      @items.push EventItem.new(description, options) if type == "event"
      @items.push LinkItem.new(description, options) if type == "link"
    else
      # if invalid item type is returned, raise an error
      handle_item_error
    end
  end

  def delete(index)
    # raise an error if index is not correct
      index <= @items.length ? @items.delete_at(index - 1) : handle_index_error
  end

  # Modify the method to accomodate filter method to print sublist
  def all(options = {})
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    print_items = options.empty? ? @items : options
    print_items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end

  # additional feature to print only the specific types needed and reuse the method all for this sublist
  def filter(item_type)
    selected_items = @items.select {|each_item| each_item.type == item_type}
    all(selected_items)
  end

private
  
  def handle_item_error
    begin
      raise UdaciListErrors::InvalidItemType, "\nAn Invalid Item Type was entered!"
    rescue Exception => e
      puts e
    end
  end

  def handle_index_error
    begin
      raise UdaciListErrors::IndexExceedsListSize, "\nAn Invalid Index number is entered!"
    rescue Exception => e
      puts e
    end
  end

end
