# frozen_string_literal: true

require_relative '../../lib/array_list'
require_relative '../../lib/daily_turns'

describe 'Array List' do

  before(:all) do
    @worker_1 = DailyTurns.new(['0-24'], 1)
    @worker_2 = DailyTurns.new(['10-14'], 2)
    @worker_3 = DailyTurns.new(['5-10'], 3)
    6.times do |_i|
      @worker_1.add_one_working_hour
      @worker_2.add_one_working_hour
      @worker_3.add_one_working_hour
    end

  end


  it 'should create a continues node' do
    supervised_hr = [9, 10]
    arr = ArrayList.new(supervised_hr, @worker_1)
    arr.add(@worker_2.worker_id, @worker_2.working_hours_counter)
    arr.add(@worker_2.worker_id, @worker_2.working_hours_counter)
    # arr.add(@worker_2.worker_id, @worker_2.working_hours_counter)
    # arr.add(@worker_1.worker_id, @worker_2.working_hours_counter)
    # arr.add(@worker_2.worker_id, @worker_2.working_hours_counter)

    arr.add(@worker_3.worker_id, @worker_3.working_hours_counter)

    arr.add(@worker_3.worker_id, @worker_3.working_hours_counter)
    # arr.add(supervised_hr, @worker_1.worker_id, @worker_1.working_hours_counter)

    p arr


    expect(arr).to eql 1

  end
end
