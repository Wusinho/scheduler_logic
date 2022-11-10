# frozen_string_literal: true

require_relative '../../bin/main'

describe 'Main build' do
  let(:bot1) { DailyTurns.new(['16-24'], 3) }
  let(:bot2) { DailyTurns.new(['0-8'], 1) }
  let(:bot3) { DailyTurns.new(['8-16'], 2) }

  let(:bot4) { DailyTurns.new(%w[0-4 8-12], 4) }
  let(:bot5) { DailyTurns.new(%w[0-4 16-24], 5) }
  let(:bot6) { DailyTurns.new(['0-24'], 6) }

  let(:bot7) { DailyTurns.new(%w[0-4], 7) }
  let(:bot8) { DailyTurns.new(%w[0-4 16-24], 8) }
  let(:bot9) { DailyTurns.new(['0-12'], 9) }

  let(:bot10) { DailyTurns.new(%w[0-24], 10) }
  let(:bot11) { DailyTurns.new(%w[0-4 8-14], 11) }
  let(:bot12) { DailyTurns.new(['9-16'], 12) }


  # it 'When given a respectable hrs ranges between workers the app arranges them' do
  #   all_turns = [bot1, bot2, bot3]
  #   monday = Day.new(all_turns, ['0-24'])
  #   monday.start
  #   expect(monday.range_supervised_hours).to eql []
  # end
  #
  # it 'When given a respectable hrs ranges between workers the app arranges them' do
  #   all_turns = [bot4, bot5, bot6]
  #   monday = Day.new(all_turns, ['0-24'])
  #   monday.start
  #   expect(monday.range_supervised_hours).to eql []
  # end
  #
  it 'When given a respectable hrs ranges between workers the app arranges them' do
    all_turns = [bot7, bot8, bot9]
    monday = Day.new(all_turns, ['0-16'])
    monday.start
    expect(monday.working_schedule).to eql [
      { hour_rage: [4, 5], worker: 9 },
      { hour_rage: [5, 6], worker: 9 },
      { hour_rage: [6, 7], worker: 9 },
      { hour_rage: [7, 8], worker: 9 },
      { hour_rage: [8, 9], worker: 9 },
      { hour_rage: [9, 10], worker: 9 },
      { hour_rage: [10, 11], worker: 9 },
      { hour_rage: [11, 12], worker: 9 }
    ]
    # expect(monday.array_nodes.each { |node| p node.print_worker_list } )
  end

  # it 'When given a respectable hrs ranges between workers the app arranges them' do
  #   all_turns = [bot10, bot11, bot12]
  #   monday = Day.new(all_turns, ['0-24'])
  #   monday.start
  # end

end
