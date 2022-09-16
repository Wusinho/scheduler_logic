# frozen_string_literal: true

require_relative '../../lib/daily_turns'

describe 'Daily turn' do
  let(:bot1) { DailyTurns.new(['0-5'], 3) }
  let(:bot2) { DailyTurns.new(%w[0-6 9-12], 1) }

  it 'creates a daily turn per worker in a day' do
    expect(bot1.available_hours).to eql [[0, 5]]
    expect(bot1.worker_id).to eql 3
    expect(bot1.worker_range).to eql [[0, 1], [1, 2], [2, 3], [3, 4], [4, 5]]
    expect(bot1.able_to_work).to be_truthy
    expect(bot1.working_hours_counter).to eql 0
  end

  it 'adds one more hour everytime the worker takes an hour of work' do
    expect { bot1.add_one_working_hour }.to change { bot1.working_hours_counter }.from(0).to(1)
    expect { bot1.add_one_working_hour }.to change { bot1.working_hours_counter }.from(1).to(2)
  end

  it 'if the worker passes the 8hrs per day it cannot be elegible to work' do
    8.times { bot1.add_one_working_hour }
    expect(bot1.working_hours_counter).to eql 8
    expect(bot1.able_to_work).to be_falsey
  end

  it 'if tried, the worker cannot receive more thant the limit of 8hrs of work per day' do
    10.times { bot1.add_one_working_hour }
    expect(bot1.working_hours_counter).to eql 8
    expect(bot1.able_to_work).to be_falsey
  end
end
