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

    if range.length == 1
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
end
