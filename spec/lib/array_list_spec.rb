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

  it 'counting the size of the node' do
    node_list = ArrayList.new([9, 10], @worker_1)
    expect { node_list.add([10, 11], @worker_2.worker_id, @worker_2.working_hours_counter) }.to change { node_list.node_size }.from(1).to(2)
    expect { node_list.add([11, 12], @worker_2.worker_id, @worker_2.working_hours_counter) }.to change { node_list.node_size }.from(2).to(3)
  end

  it 'should create node with the value in order of the workers ids' do
    node_list = ArrayList.new([9, 10], @worker_1)
    node_list.add([10, 11], @worker_2.worker_id, @worker_2.working_hours_counter)
    node_list.add([11, 12], @worker_3.worker_id, @worker_3.working_hours_counter)
    expect(node_list.print_worker_list).to eql [{ supervised_hr: [9, 10], worker_id: 1 }, { supervised_hr: [10, 11], worker_id: 2 }, { supervised_hr: [11, 12], worker_id: 3 }]
  end

  it 'as long as the working hrs are not exceeding the node will continue adding more available workers' do
    node_list = ArrayList.new([8, 9], @worker_1)
    node_list.add([9, 10], @worker_2.worker_id, @worker_2.working_hours_counter)
    node_list.add([10, 11], @worker_2.worker_id, @worker_2.working_hours_counter)
    node_list.add([11, 12], @worker_3.worker_id, @worker_3.working_hours_counter)
    expect(node_list.enable_to_sequence).to be_truthy
    expect(node_list.node_size).to eql 4
  end

  it 'when the max hrs per worker is exceed and the app tries to add more hrs, the node will be disabled' do
    node_list = ArrayList.new([9, 10], @worker_1)
    node_list.add([10, 11], @worker_2.worker_id, @worker_2.working_hours_counter)
    node_list.add([11, 12], @worker_2.worker_id, @worker_2.working_hours_counter)
    node_list.add([12, 13], @worker_2.worker_id, @worker_2.working_hours_counter)
    expect(node_list.enable_to_sequence).to be_falsey
  end




end
