# Distributed Exercises AAU talk
The network simulator at https://github.com/DEIS-Tools/DistributedExercisesAAU has been extended with a GUI that can show the execution step-by-step of a network algorithm.

The GUI can display the messages in transit in the system by highlighting the source and destination of each message being transmitted.

The stepping emulator has two interfaces that are run simultaneously, the GUI and the command line.

## Agenda
1.	The stepping emulator - how it works

<image src=processes.png>

The stepping emulators main feature is to by a command in the command line or by press of a button in the GUI it can make the emulator send a message.

This is done by the devices reaching a barrier and waiting for a 2nd process to reach the barrier. the smart thing about this is that it avoids the processes from checking a variable constantly, they just have to wait for the ui to reach the barrier in some way.

The end simulation function works by setting a variable to false and effectively disabling the stepping function

2.	The input types

It is triggered by user input with the following input types:
*	Step
	*	Step through the communication sequence a single time
		*	Triggered by pressing enter in the command line or the step button in the GUI
*	End
	*	Stops the stepping method and runs the rest of the algorithm
		*	Triggered by writing "exit" in the command line or by pressing the "end" button in the GUI
*	swap
	*	Swaps the emulator type at runtime, which means the rest of the algorithm will be run as the other type
		*	Triggered by writing "swap" in the command line or by pressing "swap emulator" in the GUI
*	Queue
	*	Has two main features, can show all messages or all messages for a specific device
		*	run by writing "queue" or "queue \<device id>" in the command line, or by either clicking a device or the "show all messages" button in the GUI
*	Pick
	*	Choose a message to be transmitted next, manipulate the queue for a specific device

3. the installation
```bash
#clone the repo
git clone https://github.com/DEIS-Tools/DistributedExercisesAAU.git
#install required dependencies
pip install -r requirements.txt
#run the GUI
python3.10 exercise_runner_overlay.py
```