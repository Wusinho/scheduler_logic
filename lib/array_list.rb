# frozen_string_literal: true

# creating a simple node
class Node
  attr_reader :supervised_hour, :worker_id
  attr_accessor :next_node, :max_working_hours

  def initialize(supervised_hour, worker_id, max_hrs_per_worker = 8, max_working_hours = 1)
    @supervised_hour = supervised_hour
    @max_hrs_per_worker = max_hrs_per_worker
    @max_working_hours = max_working_hours
    @worker_id = worker_id
    @next_node = nil
  end
end

# create arraylist
class ArrayList
  attr_reader :worker_id

  def initialize(supervised_hour, worker, max_hrs_per_hour)
    @working_hrs = 0
    @worker_hours_counter = worker.working_hours_counter
    @worker_id = worker.id
    @max_hrs_per_hour = max_hrs_per_hour
    @head = Node.new(supervised_hour, @worker_id, max_hrs_per_hour)
  end

  def add(supervised_hour)
    current_node = @head

    add_working_hrs
    current_node = current_node.next_node until current_node.next_node.nil?

    current_node.next_node = Node.new(supervised_hour, @worker_id, @max_hrs_per_hour, @working_hrs)

  end

  def print_arraylist
    current_node = @head
    puts current_node.supervised_hour
    puts current_node.supervised_hour while (current_node = current_node.next_node)
    # puts @add_working_hrs
  end

  def find_with_index(index)
    current_node = @head
    return 0 if current_node.supervised_hour.zero?

    while (current_node = current_node.next_node)
      return current_node.supervised_hour if current_node.max_working_hours == index
      # p current_node.max_working_hours
    end
  end

  def add_working_hrs
    @working_hrs += 1
  end

end



