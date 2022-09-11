# frozen_string_literal: true

require_relative 'helpers'

# creating daily-turns
class DailyTurns
  include Helpers

  attr_reader :available_hours, :worker_id, :worker_range, :name
  attr_accessor :able_to_work, :working_hours_counter

  def initialize(available_hours, worker_id)
    @available_hours = available_hours_str_to_i(available_hours)
    @worker_id = worker_id
    @worker_range = create_daily_ranges(@available_hours)
    @able_to_work = true
    @working_hours_counter = 0
  end

  def add_one_working_hour
    return unless @able_to_work

    @working_hours_counter += 1
    @able_to_work = add_more_work_hrs?
  end

  def add_more_work_hrs?
    @working_hours_counter < 8
  end

end
