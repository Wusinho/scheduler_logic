# frozen_string_literal: true

require_relative '../../bin/main'

describe 'Main build' do
  let(:bot1) { DailyTurns.new(['16-24'], 3) }
  let(:bot2) { DailyTurns.new(['0-8'], 1) }
  let(:bot3) { DailyTurns.new(['8-16'], 2) }

  let(:bot4) { DailyTurns.new(%w[0-4 8-12], 3) }
  let(:bot5) { DailyTurns.new(%w[0-4 16-24], 1) }
  let(:bot6) { DailyTurns.new(['0-24'], 2) }


  it 'When given a respectable hrs ranges between workers the app arranges them' do
    all_turns = [bot1, bot2, bot3]
    monday = Day.new(all_turns, ['0-24'])
    monday.start
    expect(monday.supervised_hours_fullfiled).to be_truthy
  end

  it 'When given a respectable hrs ranges between workers the app arranges them' do
    all_turns = [bot4, bot5, bot6]
    monday = Day.new(all_turns, ['0-24'])
    monday.start
    expect(monday.supervised_hours_fullfiled).to be_truthy
  end

end
