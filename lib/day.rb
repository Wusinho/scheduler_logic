# frozen_string_literal: true

require_relative 'helpers'

# creating day
class Day
  include Helpers

  attr_reader :conflicted_hours, :working_schedule, :conflicts
  attr_accessor :daily_turns, :supervised_hours, :range_supervised_hours

  def initialize(daily_turns, supervised_hours)
    @daily_turns = daily_turns
    @supervised_hours = available_hours_str_to_i(supervised_hours)
    @range_supervised_hours = create_daily_ranges(@supervised_hours)
    @max_hours_per_worker = 8
    @conflicts = {}
    @conflicted_hours = []
    @working_schedule = []
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

  def reset_conflictions
    @conflicts = []
    @conflicted_hours = []
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

  def find_turns_by_id(id)
    @daily_turns.find { |turn| turn.id == id }
  end

  # def checking_hours
  #   @daily_turns.each do |worker|
  #     worker.worker_range.each do |pair|
  #       next unless worker.able_to_work
  #
  #       next unless @range_supervised_hours.include?(pair) && !@conflicted_hours.include?(pair)
  #
  #       @working_schedule << { "worker_id": worker.id, "hours": pair }
  #
  #       updating_fields(worker, pair)
  #     end
  #   end
  # end

  def resolve_conflicted_hours
    return if @range_supervised_hours.empty?

    @conflicts.each do |_conflicted_hour, workers|
      p workers
      # p worker
      # @conflicted_hours.each do |conflicted_hour|
      #   next unless worker.able_to_work
      #
      #   next unless worker.worker_range.include?(conflicted_hour)
      #
      #   @working_schedule << { "worker_id": worker.id, "hours": conflicted_hour }
      #
      #   updating_workers_hours(worker, conflicted_hour)
      #   @conflicted_hours -= [conflicted_hour]
      #   next
      # end
    end
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
