require_relative 'helpers'

class DailyTurns
  include Helpers 

  attr_reader :available_hours, :id, :worker_range, :name
  attr_accessor :able_to_work, :working_hours_counter
  
  def initialize(available_hours, id, name)
    @available_hours = available_hours_str_to_i(available_hours)
    @id = id
    @name = name
    @worker_range = create_daily_ranges(@available_hours)
    @able_to_work = true
    @working_hours_counter = 0
  end

  def adding_working_hours
    @working_hours_counter += 1
  end

end

