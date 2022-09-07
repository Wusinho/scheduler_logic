# frozen_string_literal: true

# creating a simple node
class Node
  attr_reader :supervised_hour, :worker_id
  attr_accessor :next_node, :working_hrs

  def initialize(supervised_hour, worker_id, working_hrs = 1)
    @supervised_hour = supervised_hour
    @working_hrs = working_hrs
    @worker_id = worker_id
    @next_node = nil
  end

  def add_working_hr(hrs)
    @working_hrs += hrs
  end

end

# create arraylist
class ArrayList
  def initialize(supervised_hour, worker, max_hrs_per_day = 8)
    @max_hrs_per_day = max_hrs_per_day
    @enable_to_add_sequence = true
    @head = Node.new(supervised_hour, worker.id, worker.working_hours_counter)
  end

  def add(supervised_hour, worker_id, working_hours)
    return unless @enable_to_add_sequence

    current_node = @head

    until current_node.next_node.nil?
      current_node = current_node.next_node
      current_node.add_working_hr if current_node.worker_id == worker_id
    end

    current_node.next_node = Node.new(supervised_hour, worker_id, working_hours)
    current_node.add_working_hr

    @enable_to_sequence = false if continue_sequence?(current_node)

  end

  def continue_sequence?(current_node)
    current_node.working_hrs > @max_hrs_per_day
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

end



