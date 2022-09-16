# Project: Worker's Automatic Scheduler Planifier

The idea of the project is to simplify the process in which 
an organization create working schedules for their employees.

### Analyzing steps
#### 1.- Input Data
    DailyTurns, this part of the app takes the information required to build the basic (One day of work)

#### 2.- Process of Data
    Day, the app intakes the workers DailyTurns and also the range of hrs the organization needs for that specific deparment/position

The data (DailyTurns) is analyzed in order of arraival

- The App should be flexible enough to process any data. Since workers available hours are not 
    syncronized between one and another. The first part of the process consist in filling 
    unconflicted hours, that means range_hours where only one worker can fill.

    Everytime an unconflicted supervised_hour is added to the list working_schedule, that same hour 
    is substracted from range_supervised_hours. The default configuration makes the maximun hours to 
    8 per day, once this is reached, that workers is unable to take more hours. 
- For the second part, the app loops over the remaining supervised_hour and adds the time and the worker
    that has conflicts with time.
- 




    

    
        






DailyTurns information:
Every worker submits one of this per day:

    - available hours ( [9, 13])
    - worker_id
    - available hours in range ( [9,10], [10,11] ... )
    - able_to_work (it turns on/off if it has reached the max hrs per day)
    - working_hours_counter which counts the number of hrs it currently has in a day  
Day information :

    - daily_turns, all the collection of DailyTurns. All the available workers for that specific position/ department
    - supervised_hours, ( [9, 18]) the hrs that the positions needs to be filled
    - range_supervised_hours, ( [9,10], [10,11] ... )
    - conflicts, if a particular time has more than one candidate, it is stored the time and the worker
    - conflicted_hours, the time of the day that has conflicts
    - working_schedule, the result of the app when there are no conflicts
    - array_nodes, when the there are conflicts here is saved all the possible solutions to fill the conflicted shifts
    - node_series, stores the number of posibilities per level 
