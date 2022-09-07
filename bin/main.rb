# frozen_string_literal: true

require_relative '../lib/daily_turns'
require_relative '../lib/day'
require_relative '../lib/analize_combinations'
require_relative '../lib/print_table'

bot1 = DailyTurns.new(['0-24'], 3)
bot2 = DailyTurns.new(%w[0-6 9-12], 1)
bot3 = DailyTurns.new(['8-16'], 2)
bot4 = DailyTurns.new(['10-11'], 4)

all_turns = [bot1, bot2, bot3, bot4]

monday = Day.new(all_turns, ['0-24'])
# p monday.daily_turns.last
monday.fill_unconflicted_hours
monday.fill_conflicted_hours
# monday.total_nodes_counter
monday.creating_head_nodes
monday.create_node_sequence
monday.array_nodes.each do |node|
  p node
end
# p monday.array_nodes.size





# monday.array_nodes.each { |node| p node }
# p monday.range_supervised_hours
# monday.daily_turns.each { |worker| p worker.working_hours_counter}
# monday.resolve_conflicted_hours
# p monday.daily_turns
# table = PrintTable.new(monday.supervised_hours, monday.working_schedule)
# table.print_schedule
