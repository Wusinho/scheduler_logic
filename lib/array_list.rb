# frozen_string_literal: true

require_relative 'deparment_configuration'

# creating a simple node
class Node
  attr_reader :worker_id, :supervised_hour
  attr_accessor :next_node, :working_hrs_counter

  def initialize(supervised_hour, worker_id, working_hrs_counter, first_time_counter = nil)
    @supervised_hour = supervised_hour
    @worker_id = worker_id
    @working_hrs_counter = first_time_counter ? working_hrs_counter + 1 : working_hrs_counter
    @next_node = nil
  end

  def add_working_hr(hrs)
    @working_hrs_counter += hrs
  end

end

# create arraylist
class ArrayList < DepartmentConfiguration
  attr_reader :enable_to_sequence, :node_size

  def initialize(supervised_hour, worker, max_hrs_per_day = 8)
    super()
    @max_hrs_per_day = max_hrs_per_day
    @enable_to_sequence = true
    @node_size = 1
    @head = Node.new(supervised_hour, worker.worker_id, worker.working_hours_counter, true)
  end

  def add(supervised_hour, worker_id, working_hours)
    return unless @enable_to_sequence

    current_node = @head
    current_node = current_node.next_node until current_node.next_node.nil?

    reader = print_arraylist(worker_id)
    disable_list and return if reader['user_node']&.working_hrs_counter == @max_hours_per_day

    current_node.next_node = Node.new(supervised_hour,worker_id, working_hours)
    if reader['counter'].zero?
      current_node.next_node.add_working_hr(1)
    else
      current_node.next_node.add_working_hr(reader['counter'] + 1)
    end
    increase_node_size
  end

  def disable_list
    @enable_to_sequence = false
    true
  end

  def increase_node_size
    @node_size += 1
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
  end

  # return the workers ids in order
  def print_worker_list
    node = @head
    workers_ids = []
    workers_ids << node.worker_id

    while (node = node.next_node)
      workers_ids << node.worker_id
    end
    workers_ids
  end

end



