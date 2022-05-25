# Last Supervision Meeting

* I don't want to write down status stuff too much
* Israel brought better cookies
* We assume tasks with transmission is run sequentially
* requirements
    *   we have our deadline of 2.something seconds
    *   either we fit both transmission and processing into the deadline or have communication to be run seperately(evt. see blackboard) 
    *   problem isn't discussed in the report
    *   deadline should be this deadline for each subsystem, image processing subsystem and transmission subsystem in this case
    *   we can also discuss whether each subsystem has a seperate processing unit
*   deadlines are not getting met
    *   it is in other languages
    *   write about it in the discussion
    *   save the other language implementations for the exam
*   take note of testing with a large dataset as it makes the heatup of the system irrelevant and get an accurate measurement
*   it is good to test the same script multiple times rather than starting it over and over again
*   its completely fine to include files using copyright as the paper won't be published anyway
*   we need to sell the algorithms better
*   max sum subarray can be used in both the rgb and hsl algorithm
    *   kinda irrelevant when we need the matrix for clustering
*   if clustering at the ground station, the detection algorithm could return true/false with kadanes algorithm rather than ours
*   maybe we should link the two algorithms together better
*   if we haven't implemented an algorithm we don't need to include it
    *   would make sense if its a standard for this kind of problem
    *   its good to consider the different options
    *   maybe keep this discussion in the discussion chapter
*   consider how we would structure the algorithm around the different implementations of the algorithm
*   keep the discussion well structured as we have a lot to include to the discussion
    *   it would be a good idea to make a long discussion if we have a lot to discuss
*   have the discussiong BEFORE the conclusion
    *   shortly summarise the discussion
*   "why have we not been able to find images with fires"
    *   we were not able to find datasets, not fire as that can easily be found
    *   a lot of the images had infrared overlayed in them
    *   take a few cases with actual fire to show it isn't only working in theory
        *   pick something that we know we still can detect on
*   Downlink data rate
    *   it might exceed the data rate if multiple satellites transmit to the ground station
        *   in this proof-of-concept it is only run with one satelite and one ground station
        *   if the satellite is relaying from other sattelites it will most likely exceed the datarate
*   how detailed should the time complexity algorithm analysis be?
    *   good idea to add a bit of it (we did that)
*   we will send mails if we want more feedback
