require_relative '../lib/DailyTurns'
require_relative '../lib/Day'
require_relative '../lib/PrintTable'


bot_1 = DailyTurns.new(['0-24'], 3 , 'Joe')
bot_2 = DailyTurns.new(['0-6','9-12'], 1, 'Miguel')
bot_3 = DailyTurns.new(['8-16'], 2, 'Fito')

all_turns = [bot_1,bot_2,bot_3]

monday = Day.new(all_turns, ['0-24'])
monday.check_conflicted_hours
# p monday.daily_turns
# p monday.conflicted_hours
monday.resolve_conflicted_hours
# p monday.working_schedule
# p monday.check_if_supervised_hours_completed
table = PrintTable.new(monday.supervised_hours, monday.working_schedule)
table.print_schedule
# table.print_schedule

# p monday.range_supervised_hours



# monday.checking_hours

# monday.resolve_conflicted_hours
# p monday.working_schedule

# p monday.check_if_supervised_hours_completed
