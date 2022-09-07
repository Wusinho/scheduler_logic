# frozen_string_literal: true

require_relative 'helpers'
require_relative 'array_list'

# creating day
class Day
  include Helpers

  attr_reader :conflicted_hours, :working_schedule, :conflicts, :array_nodes, :nodes_series
  attr_accessor :daily_turns, :supervised_hours, :range_supervised_hours

  def initialize(daily_turns, supervised_hours)
    @daily_turns = daily_turns
    @supervised_hours = available_hours_str_to_i(supervised_hours)
    @range_supervised_hours = create_daily_ranges(@supervised_hours)
    @max_hours_per_worker = 8
    @conflicts = {}
    @conflicted_hours = []
    @working_schedule = []
    @array_nodes = []
    @nodes_series = []
  end

  def fill_conflicted_hours
    return if @range_supervised_hours.empty?

    workers_conflicted_hrs.each do |worker|
      @range_supervised_hours.each do |supervised_hour|
        add_conflicts(@conflicts, worker, supervised_hour) if worker.worker_range.include?(supervised_hour)
      end
    end

  end

  def add_conflicts(conflicts, worker, supervised_range)
    conflicts[supervised_range] = [] if conflicts[supervised_range].nil?
    conflicts[supervised_range] << worker
    @conflicted_hours << supervised_range unless @conflicted_hours.include?(supervised_range)
  end

  def fill_unconflicted_hours
    @daily_turns.length.times do |_i|
      eval_range_supervised_hours = @range_supervised_hours
      check_unconflicted_hours
      break if eval_range_supervised_hours == @range_supervised_hours

    end
  end

  def check_unconflicted_hours
    @range_supervised_hours.each do |supervised_hr|
      eval_params = { times_included: 0, unique_worker: nil }
      @daily_turns.each do |worker|
        next if !worker.able_to_work || eval_params[:times_included] >= 2

        add_params_counter(eval_params, worker) if worker.worker_range.include?(supervised_hr)
      end
      updating_workers_hours(eval_params[:unique_worker], supervised_hr) if eval_params[:times_included] == 1
    end
  end

  def add_params_counter(eval_params, worker)
    eval_params[:times_included] += 1
    eval_params[:unique_worker] = worker
  end

  def nodes_series
    total_nodes = 1
    @nodes_series = @conflicts.map { |_key, val| total_nodes *= val.size }
  end

  def remove_head_processed_sequence
    @conflicts.shift
    @nodes_series.shift
    @conflicted_hours.shift
  end

  def creating_head_nodes
    return if @range_supervised_hours.empty? || @conflicts.empty?

    nodes_series
    nodes_counter = @nodes_series.last

    times_iterating = nodes_counter / @nodes_series.first

    @conflicts.first.last.each do |worker|
      times_iterating.times do |_i|
        @array_nodes << ArrayList.new(@conflicts.first.first, worker, @max_hours_per_worker)
      end
    end
    remove_head_processed_sequence
  end

  def convert_array_to_add_series
    serialized_conflicts = @conflicts.to_a
    number_times_to_multiple_each_base(serialized_conflicts, @nodes_series)
  end

  def add_complete_series_per_level
    series_per_level = convert_array_to_add_series
    serialized_conflicts = @conflicts.to_a
    workers_per_lvl = getting_conflicts(serialized_conflicts)
    getting_series_to_add_in_nodes(workers_per_lvl, series_per_level)
  end

  def create_node_sequence
    node_sequence = add_complete_series_per_level

    node_sequence.each_with_index do |series, i|
      @array_nodes.each_with_index do |worker_node, index|
        worker_id = series[index].worker_id
        working_hours = series[index].working_hours_counter
        supervised_hours = @conflicted_hours[i]
        worker_node.add(supervised_hours, worker_id, working_hours)
      end
    end



  end

  def getting_series_to_add_in_nodes(workers_per_lvl, series_per_level)
    workers_per_lvl.map.with_index { |worker, index| worker * series_per_level[index] }
  end

  def getting_conflicts(serialized_conflicts)
    serialized_conflicts.map(&:last)
  end

  def number_times_to_multiple_each_base(serialized_conflicts, nodes_series)
    serialized_conflicts.map { |series|nodes_series.last / series.last.size }
  end

  def getting_max_times_iterations_per_base(no_iterations, node_series, divisor)
    result = []
    no_iterations.times { |index| result << node_series[index] / divisor[index] }
    result
  end

  def node_exists?(worker_id)
    @array_nodes.any? { |node| node.worker_id == worker_id }
  end

  def find_correct_node(worker_id)
    @array_nodes.select { |node| node.worker_id == worker_id }
  end

  def updating_workers_hours(worker, pair)
    @range_supervised_hours -= [pair]
    worker.add_one_working_hour
    worker.able_to_work = false if worker.working_hours_counter == @max_hours_per_worker
  end

  def workers_conflicted_hrs
    @daily_turns.find_all(&:able_to_work)
  end
end
