# frozen_string_literal: true

require 'benchmark'
require_relative 'helpers'
require_relative 'array_list'

# creating day
class Day
  include Helpers

  attr_reader :conflicted_hours, :working_schedule, :conflicts, :array_nodes, :nodes_series, :supervised_hours_fullfiled
  attr_accessor :daily_turns, :supervised_hours, :range_supervised_hours

  def initialize(daily_turns, supervised_hours)
    @daily_turns = daily_turns
    @supervised_hours = available_hours_str_to_i(supervised_hours)
    @range_supervised_hours = create_daily_ranges(@supervised_hours)
    @conflicts = {}
    @conflicted_hours = []
    @working_schedule = []
    @array_nodes = []
    @nodes_series = []
  end

  def ignite
    time = Benchmark.measure { start }
    puts time.real
  end

  def start
    fill_unconflicted_hours
    fill_conflicted_hours

    create_alternatives_on_conflicts
  end

  def create_alternatives_on_conflicts
    return if @range_supervised_hours.empty? || @conflicts.empty?

    creating_head_nodes
    create_node_sequence
  end

  def fill_conflicted_hours
    return if @range_supervised_hours.empty?

    workers_available(@daily_turns).each do |worker|
      @range_supervised_hours.each do |supervised_hour|
        if worker.worker_range.include?(supervised_hour)
          add_conflicts(@conflicts, worker, supervised_hour, @conflicted_hours)
        end
      end
    end
  end

  # loop that finishes when all the unconflicted hrs between workers are reached
  def fill_unconflicted_hours
    loop do
      eval_range_supervised_hours = @range_supervised_hours
      check_unconflicted_hours
      break if eval_range_supervised_hours == @range_supervised_hours
    end
  end

  def check_unconflicted_hours
    @range_supervised_hours.each do |supervised_hr|
      eval_params = { times_included: 0, unique_worker: nil }
      @daily_turns.each do |worker|
        next unless worker.able_to_work
        break if eval_params[:times_included] >= 2

        update_eval_params(eval_params, worker) if worker.worker_range.include?(supervised_hr)
      end
      add_unconflicted_worker_to_working_schedule(eval_params, supervised_hr) if unconflicted_hour?(eval_params)
    end
  end

  def add_unconflicted_worker_to_working_schedule(eval_params, supervised_hr)
    @working_schedule << { hour_rage: supervised_hr, worker: eval_params[:unique_worker].worker_id }
    updating_workers_hours(eval_params[:unique_worker], supervised_hr)
  end

  def creating_head_nodes
    @nodes_series = create_nodes_series(@conflicts)
    max_times_combinations = @nodes_series.last

    times_iterating = max_times_combinations / @nodes_series.first

    @conflicts.first.last.each do |worker|
      times_iterating.times { @array_nodes << ArrayList.new(@conflicts.first.first, worker) }
    end
    remove_head_processed_sequence(@conflicts, @nodes_series, @conflicted_hours)
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

    node_sequence.each_with_index do |worker, i|
      @array_nodes.each_with_index do |worker_node, index|
        next unless worker_node.enable_to_sequence

        worker_id = worker[index].worker_id
        working_hours = worker[index].working_hours_counter
        supervised_hours = @conflicted_hours[i]
        worker_node.add(supervised_hours, worker_id, working_hours)
      end
    end
  end

  def updating_workers_hours(worker, hr_range)
    @range_supervised_hours -= [hr_range]
    worker.add_one_working_hour
  end

end
