# frozen_string_literal: true

# Department configuration
class DepartmentConfiguration
  attr_reader :max_hours_per_worker

  def initialize
    @max_hours_per_worker = 8
  end

  def change_max_hours(num)
    return unless num.instance_of?(Integer)

    @max_hours_per_worker = num
  end

end
