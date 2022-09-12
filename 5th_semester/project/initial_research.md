# Initial research notes
## TCP
In Linux tcp is generally implemented by calling the `/proc/sys/net/ipv4/` directory. The congestion control is generally defined in the `/proc/sys/net/ipv4/tcp_congestion_control` file
### Slow start
Slow start is an algorithm that is part of the TCP protocol, it gradually increases the speed of the link until the connection starts being lossy.

This means that when the TCP link is estrablished it will run at very low speeds at the beginning and with each data transfer it will transfer faster until it has found the speed limit

The slow start algorithm is a part of the congestion control algorithm

<image src=ezgif-5-e0416b6d36.png></image>

The above image shows a plot of the RTT related to the congestion window. A lower RTT means a higher speed

### Maximum segment size
The MSS is the maximum size of data tcp is willing to send in a single packet, in this case the packet may be split into smaller packets and sent seperately, this is handled automatically in the protocol and any program that is using TCP does not have to worry about this issue.

### Different implementations of TCP
Congestion control algorithm itself have a lot of different implementations, these 15 are some examples of it:
*   highspeed
*   htcp
*   hybla
*   illinois
*   vegas
*   veno
*   westwood
*   bic
*   cubic

The default congestion control algorithm implementation in Linux is usually the `cubic` implementation from 2013

The congestion control is usually applied and run at the host of the connection, not the network which means some of the data about the communication is most likely closer to guesses rather than straight fact.

In general the congestion control algorithms works by maintaining a congestion window which monitors whether the connection has too many unacknowledged packets.

In case of too many unacknowledged packets the algorithm will try to let the packets take a different route to the destination host.

This algorithm is only a part of the Transmission Control Protocol, there is more to the protocol:



### Weaknesses of TCP
It is very specific, you can't really define say a bluetooth connection with TCP, as a bluetooth connection doesn't have some of the required identifiers that internet connections require and is built into TCP

It is not designed for high speed short link connections like LAN, it is designed for very long distance communication while still being compatible with the high speeds a local connection would have

Slow start will make sure that an unreliable link like a wireless link in case of a satellite moving away from another satellite is slowed down to a speed that gives the most stable rate of data, this is very useful in wired connections but in wireless connections like in our case it will be very disadvantageous
* if this happens the data rate might get so slow that a satellite constellation like starlink will be pretty much useless if it used TCP as the satellites are pretty much guaranteed to lose their link or have some loss due to an unstable link and therefore have their datarate reduced. In these cases the slow start algorithm might have to be adapted to not reduce the speed but to immediately try to find a different route to the desired destination.
### What happens in case of a broken link?
TCP maintains a connection between hosts, that means in code for example you would have a socket that is active until you close it, behind the libraries the runtime will make sure there are sent keepalive packets continually between the two systems.

in case this link is broken from an outside source, TCP will either hit a closed port where the operating system of the destination system will send a connection refused packet back to the source system

the figure below shows the closed port concept:

<image src="Connections-Attempts-a-normal-TCP-connection-b-TCP-port-closed-c-UDP-port-closed.jpg"></image>

where SYN packets are the keepalive packets and the initial packet to start the communication as part of the three-way-handshake that we know and love

This is easily detectable in the program but in this case the protocol doesn't attempt to reconnect to the destination system again, which means the program using TCP will have to solve this problem itself. This is fine as a lost link in this way usually only happens when a system loses internet connection

### How does TCP reroute in case of congestion

Initially it will most likely detect it as an unreliable link and reduce the network speed through the slow start algorithm

if the congestion window gets too many unacknowledged packets it will try to reroute

# OMNET++

# NS-3

pydia mirror:
https://mirrors.dotsrc.org/manjaro/stable/community/x86_64/dia-0.97.3-9-x86_64.pkg.tar.zst



# motivation for the project

We want to prove that it is possible to avoid slow start slowing down the tcp traffic in satellite communication when one of the two cases occur; 
* network congestion
* broken or unreliable links



# Sources
*   Congestion control: 

http://intronetworks.cs.luc.edu/1/html/newtcps.html

https://en.wikipedia.org/wiki/TCP_congestion_control#Algorithms

*   Slow start algorithm:

https://www.keycdn.com/support/tcp-slow-start