# frozen_string_literal: true

require_relative '../lib/daily_turns'
require_relative '../lib/day'
require_relative '../lib/analize_combinations'
require_relative '../lib/print_table'

bot1 = DailyTurns.new(['0-24'], 3)
bot2 = DailyTurns.new(%w[0-4 8-14], 1)
bot3 = DailyTurns.new(['9-16'], 2)

all_turns = [bot1, bot2, bot3]

monday = Day.new(all_turns, ['0-24'])
# monday.ignite
monday.start
p monday.working_schedule
p monday.conflicts.first
# p monday.max_hours_per_worker
# monday.working_schedule.each {|time| p time}
# p monday.supervised_hours_fullfiled
# monday.working_schedule.each { |hour| p hour }
# p '*'*100
# monday.array_nodes.each { |node| p node }
# p monday.conflicted_hours
# p monday.range_supervised_hours
# # monday.create_unique_nodes
# # p monday.array_nodes.sizes
# #
# # p monday.array_nodes.size
# # p monday.array_nodes.size
#
#
#
#
#
# # monday.array_nodes.each { |node| p node }
# # p monday.range_supervised_hours
# # monday.daily_turns.each { |worker| p worker.working_hours_counter}
# # monday.resolve_conflicted_hours
# # p monday.daily_turns
# # table = PrintTable.new(monday.supervised_hours, monday.working_schedule)
# # table.print_schedule
