# frozen_string_literal: true

# helper methods
module Helpers
  def create_hourly_ranges(range)
    hour_ranges = []
    range.sort!
    range.each { |hour| hour_ranges << [hour, hour + 1] if range.include?(hour + 1) }
    hour_ranges
  end

  def available_hours_str_to_i(range)
    workers_ranges = []

    if range.length.eql? 1
      workers_ranges << range.first.split('-').map(&:to_i)
    else
      range.each do |workers_hr_range|
        workers_ranges << workers_hr_range.split('-').map(&:to_i)
      end
    end
    workers_ranges
  end

  def create_daily_ranges(range)
    hourly_range = if range.length == 1
                     (range.first[0].to_i..range.first[1].to_i).to_a
                   else
                     range.map { |worker_range| (worker_range[0]..worker_range[1]).to_a }.flatten
                   end
    create_hourly_ranges(hourly_range)
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

  def update_eval_params(eval_params, worker)
    eval_params[:times_included] += 1
    eval_params[:unique_worker] = worker
  end

  def add_conflicts(conflicts, worker, supervised_range, conflicted_hours)
    conflicts[supervised_range] = [] if conflicts[supervised_range].nil?
    conflicts[supervised_range] << worker
    conflicted_hours << supervised_range unless conflicted_hours.include?(supervised_range)
  end

  def unconflicted_hour?(eval_params)
    eval_params[:times_included] == 1
  end

  def remove_head_processed_sequence(conflicts, nodes_series, conflicted_hours)
    conflicts.shift
    nodes_series.shift
    conflicted_hours.shift
  end

  def workers_available(daily_turns)
    daily_turns.find_all(&:able_to_work)
  end

  def create_nodes_series(conflicts)
    total_nodes = 1
    conflicts.map { |_key, val| total_nodes *= val.size }
  end

  def test_nodec_creation(conflicts)
    total_nodes = 1
    conflicts.map do |_key, val|
      total_nodes *= val.size
      p total_nodes
    end
  end


end
