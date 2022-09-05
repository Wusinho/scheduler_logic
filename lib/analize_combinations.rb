# frozen_string_literal: true

require_relative 'helpers'

# class to read the right sequence combination
class CombinationReader
  include Helpers

  attr_reader :conflicts

  def initialize(conflicts)
    @conflicts = conflicts
  end

end
