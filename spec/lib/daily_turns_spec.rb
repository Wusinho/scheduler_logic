# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/daily_turns'

describe 'Daily turn' do
  let(:bot1) { DailyTurns.new(['0-24'], 3) }
  let(:bot2) { DailyTurns.new(%w[0-6 9-12], 1) }

  it 'creates a daily turn per worker in a day' do
    expect(bot1.available_hours).to eql [[0, 24]]
    expect(bot1.worker_id).to eql 3
    expect(bot1.worker_range).to eql [[0, 1], [1, 2], [2, 3], [3, 4], [4, 5], [5, 6], [6, 7], [7, 8], [8, 9], [9, 10], [10, 11], [11, 12], [12, 13], [13, 14], [14, 15], [15, 16], [16, 17], [17, 18], [18, 19], [19, 20], [20, 21], [21, 22], [22, 23], [23, 24]]
    expect(bot1.able_to_work).to be_truthy
    expect(bot1.working_hours_counter).to eql 0
  end

  it 'if the worker passes the 8hrs per day it cannot be elegible to work' do
    8.times { |_i| bot1.add_one_working_hour }
    expect(bot1.working_hours_counter).to eql 8
    expect(bot1.able_to_work).to be_falsey
  end
end
