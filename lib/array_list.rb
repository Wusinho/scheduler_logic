# frozen_string_literal: true

# creating a simple node
class Node
  attr_reader :value
  attr_accessor :next_node, :position

  def initialize(value, position = 0)
    @value = value
    @next_node = nil
    @position = position
  end

end

# create arraylist
class ArrayList
  def initialize(value)
    @head = Node.new(value)
    @index = 0
  end

  def add(value)
    current_node = @head

    index_counter
    until current_node.next_node.nil?
      current_node = current_node.next_node
      # p current_node.value

    end

    current_node.next_node = Node.new(value, @index)

  end

  def print_arraylist
    current_node = @head
    puts current_node.value
    puts current_node.value while (current_node = current_node.next_node)
    # puts @index
  end

  def find_with_index(index)
    current_node = @head
    return 0 if current_node.value.zero?

    while (current_node = current_node.next_node)
      return current_node.value if current_node.position == index
      # p current_node.position
    end
  end

  def index_counter
    @index += 1
  end

end


nuevo = ArrayList.new(4)
nuevo.add(5)
nuevo.add(3)
nuevo.add(1)
# puts nuevo.find_with_index(0S)
nuevo.print_arraylist
