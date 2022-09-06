# frozen_string_literal: true

# class to read the right sequence combination
class AnalizeCombinations
  attr_accessor :daily_turns, :conflicts

  def initialize(daily_turns)
    @daily_turns = daily_turns
    @conflicts = []
    @posible_solutions = []
  end

  def combination_reader(turns)
    @daily_turns = daily_turns
    @supervised_hours = available_hours_str_to_i(supervised_hours)
    @range_supervised_hours = create_daily_ranges(@supervised_hours)
    @max_hours_per_worker = 8
    @conflicts = []
    @conflicted_hours = []
    @working_schedule = []
  end

end
