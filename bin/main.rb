# frozen_string_literal: true

require_relative '../lib/DailyTurns'
require_relative '../lib/Day'
require_relative '../lib/PrintTable'

bot_1 = DailyTurns.new(['0-24'], 3, 'Joe')
bot_2 = DailyTurns.new(%w[0-6 9-12], 1, 'Miguel')
bot_3 = DailyTurns.new(['8-16'], 2, 'Fito')

all_turns = [bot_1, bot_2, bot_3]

monday = Day.new(all_turns, ['0-24'])
monday.check_conflicted_hours
monday.resolve_conflicted_hours
table = PrintTable.new(monday.supervised_hours, monday.working_schedule)
table.print_schedule
