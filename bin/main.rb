# frozen_string_literal: true

require_relative '../lib/daily_turns'
require_relative '../lib/day'
require_relative '../lib/print_table'

bot1 = DailyTurns.new(['0-24'], 3)
bot2 = DailyTurns.new(%w[0-6 9-12], 1)
bot3 = DailyTurns.new(['8-16'], 2)

all_turns = [bot1, bot2, bot3]

monday = Day.new(all_turns, ['0-24'])
monday.check_conflicted_hours
monday.resolve_conflicted_hours
table = PrintTable.new(monday.supervised_hours, monday.working_schedule)
table.print_schedule
