class UdaciList
  include Listable
  attr_reader :title, :items
  # implement the item types as a class array for easier scaling and tracking
  @@item_types = ["todo","event","link","game"]

  def initialize(options={})
    # Added default title if none given
    @title = options[:title] || "Untitled List"
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase
    # Added item type check which starts initialization only if true
    if @@item_types.include?(type)
      if type == "todo"       # Stop the push to the items array if initialization for Todo fails because of invalid priority
        new_item = TodoItem.new(description, options)
        @items.push(new_item) if new_item.type
      end
      @items.push EventItem.new(description, options) if type == "event"
      @items.push LinkItem.new(description, options) if type == "link"
      @items.push GameItem.new(description, options) if type == "game"
    else
      handle_item_error # if invalid item type is returned, raise an error
    end
  end

  def delete(index)
    # raise an error if index is not correct
      index <= @items.length ? @items.delete_at(index - 1) : handle_index_error
  end

  # Modify the method to accomodate filter method to print sublist
  # Added artii class for title
  def all(options = {})
    puts "-" * @title.length
    puts @title.colorize(:color => :white, :background => :cyan)
    puts "-" * @title.length
    print_items = options.empty? ? @items : options
    print_items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end

  # Required feature to print only the specific types needed and reuse the method all for this sublist
  def filter(item_type)
    selected_items = @items.select {|each_item| each_item.type == item_type}
    all(selected_items)
  end

  # Using Gem terminal-table to print item array in a nicer format
  def print_nice_all
    format_item_array = Array.new
    # Populate into new array with formatted rows
    @items.each_with_index {|each_item, position| format_item_array << [position + 1, format_beautify(each_item.details)]}
    item_table = Terminal::Table.new do | table | # create new table with the formatting 
      table.title = @title.colorize(:color => :white, :background => :cyan) ; table.headings = ['No.', 'Description']
      format_item_array.each {|each_item| table << each_item; table.add_separator}
    end
    puts item_table
  end

  # Extra feature to delete multiple items
  def delete_many(list_of_indexes)
    unwanted_item_array = Array.new
    list_of_indexes.each {| each_index | unwanted_item_array << @items[each_index-1]}
    @items -= unwanted_item_array
  end

private

  # Handle invalid item type error  
  def handle_item_error
    begin
      raise UdaciListErrors::InvalidItemType, "\nAn Invalid Item Type was entered!"
    rescue Exception => e
      puts e
    end
  end
  
  # Handle invalid index number error  
  def handle_index_error
    begin
      raise UdaciListErrors::IndexExceedsListSize, "\nAn Invalid Index number is entered!"
    rescue Exception => e
      puts e
    end
  end

end
