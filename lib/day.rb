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
    @conflicts = []
    @conflicted_hours = []
    @working_schedule = []
  end

  def add_conflicts(conflicts, range1, range2, range, conflicted_hours)
    conflicts << { "worker_id": range1.id, "hours": range }
    conflicts << { "worker_id": range2.id, "hours": range }
    conflicted_hours << range
  end

  def reset_conflictions
    @conflicts = []
    @conflicted_hours = []
  end

  def check_conflicted_hours
    loop_counter = 0

    until loop_counter == @daily_turns.size

      ids = []
      reset_conflictions

      @daily_turns.each { |worker| ids << worker.id if worker.able_to_work }

      if ids.length != 1

        combined_ids = ids.combination(2).to_a

        combined_ids.each do |combination|
          worker1 = find_turns_by_id(combination[0])
          worker2 = find_turns_by_id(combination[1])

          worker1.worker_range.each do |range|
            if worker2.worker_range.include?(range)
              add_conflicts(@conflicts, worker1, worker2, range,
                            @conflicted_hours)
            end
          end
        end
      end

      @daily_turns.each do |worker|
        worker.worker_range.each do |pair|
          next unless worker.able_to_work

          next unless @range_supervised_hours.include?(pair) && !@conflicted_hours.include?(pair)

          @working_schedule << { "worker_id": worker.id, "hours": pair }

          updating_fields(worker, pair)
        end
      end

      loop_counter += 1

    end
    puts @conflicts
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

    select_workers_able_to_work.each do |worker|
      @conflicted_hours.each do |conflicted_hour|
        next unless worker.able_to_work

        next unless worker.worker_range.include?(conflicted_hour)

        @working_schedule << { "worker_id": worker.id, "hours": conflicted_hour }

        updating_fields(worker, conflicted_hour)
        @conflicted_hours -= [conflicted_hour]
        next
      end
    end
  end

  def updating_fields(worker, pair)
    @range_supervised_hours -= [pair]
    worker.adding_working_hours
    worker.able_to_work = false if worker.working_hours_counter == @max_hours_per_worker
  end

  def select_workers_able_to_work
    @daily_turns.find_all(&:able_to_work)
  end
end
