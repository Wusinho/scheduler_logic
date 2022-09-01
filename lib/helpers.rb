
module Helpers

  def create_hourly_ranges(range)
    hour_ranges = []
    range.sort!
    range.each { | hour | hour_ranges << [ hour , hour + 1] if range.include?(hour + 1) }
    hour_ranges
  end
  
  def available_hours_str_to_i(range)
    workers_ranges = []
      
    if range.length == 1
      workers_ranges  << range.first.split('-').map { |num| num.to_i}
    else
      range.each { | workers_hr_range | workers_ranges << workers_hr_range.split('-').map { | string_num | string_num.to_i } }
    end
      workers_ranges
  end

  def create_daily_ranges(range)
    if range.length == 1
      hourly_range = (range.first[0].to_i..range.first[1].to_i).to_a
    else
      hourly_range = range.map { | worker_range| (worker_range[0]..worker_range[1]).to_a }.flatten
    end
    create_hourly_ranges(hourly_range)

  end


end
