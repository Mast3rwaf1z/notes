
# Tidsplan.
* work on the design chapter such that the idea is clear before implementation
  * important to determine how long it will take to implement
## Task allocation & expectations.
* how successfull will we expect the project to be?
  * israel expects a proof of concept
  * we want the project to succeed
* we're not really considering edge computing
  * compressing and detection on the satellite is edge computing
  * defining our system as edge computing is not really important
* we should determine how to test the system (starting a fire is not a good idea)
  * top down fire pictures is hard  to find
  * we could generate pictures ourselves
  * we could also take the red channel out of the picture
* using a normal camera makes sense if it is supposed to be a general purpose EO satellite, since it makes sense to use infrared on fires but in other scenarios, an optical camera might make more sense
* we can test the previous points a bit before next meeting
* the success of the project and grades are not equal
* morale of the group can fall a lot behind if the implementation is not progressing
* make a list of tasks in the design and implementation as soon as possible
 * get the camera to work
 * compression
  * algorithm design: we have algorithms to compress clearly defined but if it isn't interesting, focus some more on detection algorithms
 * finish the technical analysis
* determine how exactly the fire detection will be implemented
# Fire detcetion algorithms. (moh)
* go for some simple algorithms and try to get them to work with our project
* algorithm will not be simple to come up with
# Question about: General compression [comment from Anders] (ras)
* we wrote about jpeg before compression
 * introduce general compression first, then the specific compression types
# susannes questions: passive sensors
* answer: a passive camera just takes the energy from the sun where active sensors send power out from the camera to take the pictur
# report
* requirements before design (as always)
* sequence diagram? like in HPP with distributing tasks?
* clearly defined functions of product in design
* figure 5.1 and section before design.
## implementation
* do we have any specifics on the implementation? (israel)
  * compression, taking a picture, libcamera, python
* will compression mess with the detection algorithm? (israel)
* if we do not detect a fire there is no reason to compress
* each point in the image will be quite large (israel said 32 meters)
* focus on the image as a matrix
