# frozen_string_literal: true

require_relative '../../bin/main'

describe 'Main build' do
  let(:bot1) { DailyTurns.new(['16-24'], 3) }
  let(:bot2) { DailyTurns.new(['0-8'], 1) }
  let(:bot3) { DailyTurns.new(['8-16'], 2) }

  let(:bot4) { DailyTurns.new(%w[0-4 8-12], 3) }
  let(:bot5) { DailyTurns.new(%w[0-4 16-24], 1) }
  let(:bot6) { DailyTurns.new(['0-24'], 2) }

  let(:bot7) { DailyTurns.new(%w[0-4], 3) }
  let(:bot8) { DailyTurns.new(%w[0-4 16-24], 1) }
  let(:bot9) { DailyTurns.new(['0-24'], 2) }


  it 'When given a respectable hrs ranges between workers the app arranges them' do
    all_turns = [bot1, bot2, bot3]
    monday = Day.new(all_turns, ['0-24'])
    monday.start
    expect(monday.range_supervised_hours).to eql []
  end

  it 'When given a respectable hrs ranges between workers the app arranges them' do
    all_turns = [bot4, bot5, bot6]
    monday = Day.new(all_turns, ['0-24'])
    monday.start
    expect(monday.working_schedule).to eql [{ hour_rage: [4, 5], worker: 2 }, { hour_rage: [5, 6], worker: 2 }, { hour_rage: [6, 7], worker: 2 }, { hour_rage: [7, 8], worker: 2 }, { hour_rage: [12, 13], worker: 2 }, { hour_rage: [13, 14], worker: 2 }, { hour_rage: [14, 15], worker: 2 }, { hour_rage: [15, 16], worker: 2 }, { hour_rage: [16, 17], worker: 1 }, { hour_rage: [17, 18], worker: 1 }, { hour_rage: [18, 19], worker: 1 }, { hour_rage: [19, 20], worker: 1 }, { hour_rage: [20, 21], worker: 1 }, { hour_rage: [21, 22], worker: 1 }, { hour_rage: [22, 23], worker: 1 }, { hour_rage: [23, 24], worker: 1 }, { hour_rage: [0, 1], worker: 3 }, { hour_rage: [1, 2], worker: 3 }, { hour_rage: [2, 3], worker: 3 }, { hour_rage: [3, 4], worker: 3 }, { hour_rage: [8, 9], worker: 3 }, { hour_rage: [9, 10], worker: 3 }, { hour_rage: [10, 11], worker: 3 }, { hour_rage: [11, 12], worker: 3 }]

  end

end
