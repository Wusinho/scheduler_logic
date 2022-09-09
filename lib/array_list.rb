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
    @enable_to_add_sequence = true
    @head = Node.new( worker.worker_id, worker.working_hours_counter, true)
  end

  def add(worker_id, working_hours)
    return if !@enable_to_add_sequence

    current_node = @head
    # @enable_to_add_sequence = false and return continue_sequence?(current_node, worker_id)

    until current_node.next_node.nil?

      current_node = current_node.next_node

      # current_node.add_working_hr if current_node.worker_id == worker_id
    end
    hrs = print_arraylist(worker_id)
    # primera ve z q se agrega un nuevo user la nodo
    p "no_ofhrs = #{hrs}"
    # hrs = 1 if hrs <= 1
    if hrs.zero?
      p 'hrs zero'
    current_node.next_node = Node.new(worker_id, working_hours)
      current_node = current_node.next_node
      current_node.add_working_hr(1)
      p current_node
    else
      p 'otherr'

      current_node.next_node = Node.new(worker_id, working_hours)
      current_node.next_node.add_working_hr(hrs + 1)
      p current_node.next_node

    end
    puts '*'*100
    # print_arraylist(worker_id)
    p @head
    puts '*'*100

    puts 'end of add'
  end

  def check_nodes
    current_node = @head

  end

  def continue_sequence?(current_node, worker_id)
    current_node.add_working_hr == @max_hrs_per_day #&& current_node.worker_id == worker_id
  end


  def print_arraylist(worker_id)
    current_node = @head
    hr_token_counter = 0
    # add_working_hr
    hr_token_counter += 1 if current_node.worker_id == worker_id

    puts "#{current_node.worker_id} with counter = #{current_node.working_hrs_counter}"

    while (current_node = current_node.next_node)
      hr_token_counter += 1 if current_node.worker_id == worker_id
      puts "#{current_node.worker_id} with counter = #{current_node.working_hrs_counter}"
    end
    hr_token_counter
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



