# frozen_string_literal: true

# Department configuration
class DepartmentConfiguration
  attr_accessor :max_hours_per_worker

  def initialize
    @max_hours_per_worker = 8
  end
end
