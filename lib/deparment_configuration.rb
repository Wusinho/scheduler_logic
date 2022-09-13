# frozen_string_literal: true

# Department configuration
class DepartmentConfiguration
  attr_reader :max_hours_per_day, :min_hours_per_week

  def initialize
    @max_hours_per_day = 8
    @min_hours_per_week = 40
  end

  def change_max_hours_per_day(num)
    return unless num.instance_of?(Integer)

    @max_hours_per_day = num
  end

  def change_max_hours_per_week(num)
    return unless num.instance_of?(Integer)

    @min_hours_per_week = num
  end

end
