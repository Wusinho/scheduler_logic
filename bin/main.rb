# frozen_string_literal: true

require_relative '../lib/daily_turns'
require_relative '../lib/day'
require_relative '../lib/analize_combinations'
require_relative '../lib/print_table'

bot1 = DailyTurns.new(['0-24'], 3)
bot2 = DailyTurns.new(%w[0-6 9-12], 1)
bot3 = DailyTurns.new(['8-16'], 2)

all_turns = [bot1, bot2, bot3]

monday = Day.new(all_turns, ['0-24'])
# p monday.daily_turns.last
monday.loop_unconflicted_hours
# p monday.range_supervised_hours
monday.daily_turns.each { |worker| p worker.working_hours_counter}
# monday.resolve_conflicted_hours
# p monday.daily_turns
# table = PrintTable.new(monday.supervised_hours, monday.working_schedule)
# table.print_schedule
