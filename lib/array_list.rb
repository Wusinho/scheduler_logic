# frozen_string_literal: true

# creating a simple node
class Node
  attr_reader :supervised_hour, :worker_id
  attr_accessor :next_node, :working_hrs_counter

  def initialize(worker_id, working_hrs_counter, first_time_counter = nil)
    @worker_id = worker_id
    @working_hrs_counter = first_time_counter ? working_hrs_counter + 1 : working_hrs_counter
    @next_node = nil
  end

  def add_working_hr(hrs)
    @working_hrs_counter += hrs
  end

end

# create arraylist
class ArrayList
  def initialize(supervised_hour, worker, max_hrs_per_day = 8)
    @supervised_hour = supervised_hour
    @max_hrs_per_day = max_hrs_per_day
    @enable_to_sequence = true
    @head = Node.new( worker.worker_id, worker.working_hours_counter, true)
  end

  def add(worker_id, working_hours)
    return unless @enable_to_sequence

    current_node = @head
    current_node = current_node.next_node until current_node.next_node.nil?

    reader = print_arraylist(worker_id)
    disable_list and return if reader['user_node']&.working_hrs_counter == 8

    current_node.next_node = Node.new(worker_id, working_hours)
    return current_node.next_node.add_working_hr(1) if reader['counter'].zero?

    current_node.next_node.add_working_hr(reader['counter'] + 1)

  end

  def disable_list
    @enable_to_sequence = false
    true
  end

  def continue_sequence?(current_node, worker_id)
    current_node.add_working_hr == @max_hrs_per_day #&& current_node.worker_id == worker_id
  end


  # adds a counter of hrs everytime a worker can fill th shift
  # And return the node of the user to check if it can continue to work
  def print_arraylist(worker_id)
    reader = {}
    current_node = @head
    hr_token_counter = 0

    hr_token_counter += 1 if current_node.worker_id == worker_id

    while (current_node = current_node.next_node)
      if current_node.worker_id == worker_id
        hr_token_counter += 1
        reader['user_node'] = current_node
      end
    end
    reader['counter'] = hr_token_counter
    reader
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



