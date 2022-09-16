# frozen_string_literal: true

require_relative '../../lib/array_list'
require_relative '../../lib/daily_turns'

describe 'Array List' do

  before(:all) do
    @worker_1 = DailyTurns.new(['0-24'], 1)
    @worker_2 = DailyTurns.new(['10-14'], 2)
    @worker_3 = DailyTurns.new(['5-10'], 3)
    6.times{
      @worker_1.add_one_working_hour
      @worker_2.add_one_working_hour
      @worker_3.add_one_working_hour
    }

  end


  it 'should create node with the value in order of the workers ids' do
    supervised_hr = [9, 10]
    node_list = ArrayList.new(supervised_hr, @worker_1)
    node_list.add(supervised_hr, @worker_2.worker_id, @worker_2.working_hours_counter)
    node_list.add(supervised_hr, @worker_3.worker_id, @worker_3.working_hours_counter)
    expect(node_list.print_worker_list).to eql [{supervised_hr: [9, 10], worker_id: 1}, {supervised_hr: [9, 10], worker_id: 2}, {supervised_hr: [9, 10], worker_id: 3}]
  end

  it 'as long as the working hrs are not exceeding the node will continue adding more available workers' do
    supervised_hr = [10, 11]
    node_list = ArrayList.new(supervised_hr, @worker_1)
    node_list.add(supervised_hr, @worker_2.worker_id, @worker_2.working_hours_counter)
    node_list.add(supervised_hr, @worker_2.worker_id, @worker_2.working_hours_counter)
    node_list.add(supervised_hr, @worker_3.worker_id, @worker_3.working_hours_counter)
    node_list.add(supervised_hr, @worker_3.worker_id, @worker_3.working_hours_counter)
    node_list.add(supervised_hr, @worker_1.worker_id, @worker_1.working_hours_counter)
    expect(node_list.node_size).to eql 6
  end

  it 'when the max hrs per worker is exceed it will stop taking more workers and will be disabled ' do
    supervised_hr = [10, 11]
    node_list = ArrayList.new(supervised_hr, @worker_1)
    node_list.add(supervised_hr, @worker_2.worker_id, @worker_2.working_hours_counter)
    node_list.add(supervised_hr, @worker_2.worker_id, @worker_2.working_hours_counter)
    node_list.add(supervised_hr, @worker_2.worker_id, @worker_2.working_hours_counter)
    node_list.add(supervised_hr, @worker_2.worker_id, @worker_2.working_hours_counter)
    expect(node_list.enable_to_sequence).to be_falsey
    expect(node_list.print_worker_list).to eql [{supervised_hr: [10, 11], worker_id: 1}, {supervised_hr: [10, 11], worker_id: 2}, {supervised_hr: [10, 11], worker_id: 2}]
    expect(node_list.node_size).to eql 3

  end




end
