class UdaciList
 # include UdaciListErrors
  attr_reader :title, :items

  def initialize(options={})
    # Added default title if none given
    @title = options[:title] || "Untitled List"
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase
    # Added item type check which initializes only if true
    if item_validity_check(type)
      #probably do a check to avoid push if initialization fails
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

  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end

private
  
  # perhaps merge the below check to the add method to reduce number of methods?
  def item_validity_check(input_type)
    ["todo","event","link"].member?(input_type)
  end

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
