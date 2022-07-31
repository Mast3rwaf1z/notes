# Meeting notes
## Preperation
what is the issue with starting the testing framework?
*	I noticed you were using python3.9, i've updated the framework to the newest version of python which is python3.10, so that might fix the issue
	*	I think there are multiple possibilities here, i'm personally most familiar with python3.10 so i don't know for sure but i have some typing defined for syntax highlighting that might cause the issue
		*	it is defined as shown below:
		```python
		def listener(key:keyboard.KeyCode | keyboard.Key):
			#something
			pass
		```
		*	Where the issue comes at the "or" symbol shown with "|", i think there are two possibilities with whats wrong, the error is describing an enum and a type, i think there might have been an update to pynput between python 3.9 and python 3.10 which changed the definition of key and keycode. It could also just be python3.9 not supporting the "or" operator in function parameter type definitions
*	Regardless of what the issue is, i personally think we should just keep the software up to date, and it works completely fine in python3.10 as it is so the change is most likely just in the readme

Should i change the command in the readme to the new overlay i made? i saw you tried to use the flags of the software, i have made a GUI which functions identically.

go through how to execute the framework now
### FAQ stuff
What questions do you have about the software?

Is the GUI intuivive?

Is the install process intuitive?

What is the framework actually about in your words(i know what it is, its just for reference and a new view on it)

### Demo n shit
clone repo before and after, i want feedback on the GUI change

the cloned repos are under `~/work/before`, `~/work/after` and `~/work/unit-testing`

show the unit testing software
## During
