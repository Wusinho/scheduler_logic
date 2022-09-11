Project: Worker's Automatic Scheduler Planifier

The idea of the project is to simplify the process in which 
an organization create working schedules for their employees.

Analyzing steps
1.- Input Data
    DailyTurns, this part of the app takes the information required to build the basic (One day of work)
    
2.- Process of Data
    Day, the app intakes the workers DailyTurns and also the range of hrs the organization needs for that specific deparment/position

The data (DailyTurns) is analyzed in order of arraival



    

    
        






DailyTurns information:
Every worker submits one of this per day.
    - available hours ( [9, 13])
    - worker_id
    - available hours in range ( [9,10], [10,11] ... )
    - able_to_work (it turns on/off if it has reached the max hrs per day)
    - working_hours_counter which counts the number of hrs it currently has in a day  
Day information
    - daily_turns, all the collection of DailyTurns. All the available workers for that specific position/ department
    - supervised_hours, ( [9, 18]) the hrs that the positions needs to be filled
    - range_supervised_hours, ( [9,10], [10,11] ... )
    - max_hours_per_worker, max hrs a worker can work in that position 
    - conflicts, if a particular time has more than one candidate, it is stored the time and the worker
    - conflicted_hours, the time of the day that has conflicts
    - working_schedule, the result of the app when there are no conflicts
    - array_nodes, when the there are conflicts here is saved all the possible solutions to fill the conflicted shifts
    - node_series, stores the number of posibilities per level 
    - supervised_hours_fullfiled, checks if the supervised hours are fullfiled or not for that deparment/position
