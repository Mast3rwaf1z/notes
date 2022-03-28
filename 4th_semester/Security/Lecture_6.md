# Lecture 6

* antivirus isnt really secure
* anomaly detection requires knowledge
* thr most important aspect is to analyse the packets in the system
## virus side detection
* VM detection
	* virtual hardware
	* memory alloc
* er der overvågning
## low vs high baseline?
* parametre er vigtigt
## machine learning

## VBS example
* malware that listens on network card
* sends data to a database
* network traffic
	* flow
	* process
* in case of surveillance, people browse differently when they know theyre being monitored
	* in this case the student installed it on all the computers in a school without consent and got a lot more data
## DNS
* flux
	* using flux you can get the dns to return a different host every time they query.
	* TTL is low
	* hard to detect
	* still often a proxy between DNS and C&C
## blacklist
* hard to blacklist flux
* kinda outdated
* not updated often in some cases
## whitelist
* maybe a bit better than blacklist
## deep packet inspection
* requires a lot of resources
* impossible with encryption
* impl
	* firewall, IDS, IPS
* data leak prevention
* prioritation of packets
* targets annomalies
* looks at data over more packets
* false positives is an issue
* port number
* string matching
	* requires unencrypted
* behaviour
* protocol
* application (spotify, zoom, teams etc...)

