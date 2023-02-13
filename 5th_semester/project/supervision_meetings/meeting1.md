# supervision meeting #1
*   we have not discussed which direction we are taking the project yet
    *   for next friday meeting
*   we want to evaluate TCP over satellite links
*   three different ways to evaluate
    *   pen and paper
    *   implement everything as it would be in production
    *   simulation

*   we want something in between a simple modeling and a production system
*   there is also a possibility to do some emulation (testbed)
*   it will cost less as it is not a system in production
*   it would also not be scalable to do emulation
    *   its more difficult to scale it
*   less control over a wireless signal
*   how do we make a realistic wireless channel
    *   easy on emulation, hard on simulation
*   the channel can be made by tinkering with specific attributes on the simulated channel
*   the channel needs to both be well defined but also we need to make sure it accurately models the wireless satellite link
*   relatively easy to make a model of a link in a simulation
*   we need to concider what the most important thing to simulate is
*   we need to consider where on the OSI model we put our focus - the network topology
*   we will never finish the simulation if we need to model everything to the greatest detail
*   since we're looking into TCP we need to model TCP to the greatest detail
###   TCP
*   flow control
*   we need to capture the main traits in the behaviour
*   Limitations
    *   how do we model the network channel
    *   how do we model the topology
*   do we need to look into MAC or routing
*   how large a satellite constellation do we want to model
*   define some smaller limited simulations - models
    *   build larger models if there is a need

### report
*   we need to consider the requirement specification and tests
*   this is not a product, this is a simulator for research
*   instead of testing and finishing, we are testing the system, then using it and making a conclusion based on that
    *   this project is by nature more scientific than product oriented so we should focus on that

*   discuss different simulators in the technical analysis