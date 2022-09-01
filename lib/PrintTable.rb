require_relative 'helpers'

class PrintTable
  include Helpers 

  def initialize(supervised_hours, schedule)
    @supervised_hours = supervised_hours
    @schedule = schedule
    
  end

  def print_schedule
    daily_sifts = create_daily_ranges(@supervised_hours)
    daily_sifts.each do | hour |

      selected =  @schedule.find { |ele| ele[:hours] == hour }
      if selected
        print_square(selected[:hours], selected[:worker_id])
      else
        print_square(hour, '---')

      end
    end
  end

  def print_square(hour, id)
    puts "| #{hour}  |  #{id}  |\n-----------------"
    
  end

end