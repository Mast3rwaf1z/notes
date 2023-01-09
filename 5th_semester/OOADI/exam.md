# Analysis

**use case analysis**<br>
very important, this proceedure can begin by defining a scenario, something like a creative writing. Here the text will be used to describe how to define the problem in a use case diagram. There will be actors outside the system and use cases within the system. Lets take the example of a discord bot: There are three types of actors in this system, there is the user, which can interact with the music functionality of the bot, interact with the public commands. The administrator can configure the bot and descide on which permissions it can have on their discord server. And then there's the developer, they can have a channel in which the bot reports errors to them, and they can read through and fix the errors coming in.

This is the scope of the system.

## FURPS+
| Functionality  | music, manage teams, log joins and leaves, log commands                                                                                                                     |
|----------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Usability      | The bot should have two interfaces; a CLI and commands in discord                                                                                                           |
| Reliability    | The bot should be implemented such that a feature implementation REQUIRES it to return a response for the user of a command, otherwise it shouldn't compile                 |
| Performance    | To ensure the bot has time to process the bot should where possible respond with "bot is thinking..." as fast as possible to let the user know the bot received the command |
| Sustainability | The features added will be modularized such that the event listeners doesn't need to be updated often, this will prevent future errors                                      |

**The domain model**<br>
The domain model is generally the same thing as a class diagram, just with a lot less detail, it often serves as a model to get started with the project and in many ways i think you can build your class diagram off of the domain model, key differences is that i think some objects in the domain model can essentially be different things but they're from the same class, making the two not strictly compatible. The domain model contains the objects in the system, along with relations between many of these, lets say we have a raid team handler, and a slash command handler, these interact with each other not directly but by the slash command handler calling the feature that was called with a slash command, where this feature might call the raid team manager directly. so that domain model might contain the following relationship: <br> 
$$SlashCommandHandler \rArr RaidTeamManageFeature \rArr RaidTeamManager$$
As we described above that the slash commands should be abstracted to a class per command loaded automatically with a classloader, such that the SlashCommandHandler will not need to be updated every time a new feature is added.

The domain model is additionally also characterized by showing the interaction between classes rather than how they are implemented as shown in the class diagram.

**Object analysis**<br>
Object analysis is done by writing texts describing scenarios where a user might interact with the system. once the text has been written it will be analysed for keywords that might become objects, attributes and methods. an example using the discord bot example is shown below
```
A user joins the voice channel, they want to listen to some music so they call the bot with a slash command. The slash command replies to the user with "Bot is thinking..." while the bot requests the track from Youtube. once youtube has replied to the get request, the bot will categorize the result between a search result, a specific track or a playlist, or an error and reply to the user the result of the command followed by joining the voice channel according to the result.
```
The objects can be identified by nouns: user, voice channel, bot, slash command, track, Youtube, playlist, error, command

and some attributes based on their function: reply: string
# Design
The design starts with a class diagram, it will take all the objects as defined in the analysis and define a class containing all the attributes used and the methods the class will contain, lets take the example of the slashcommandlistener again:

```
+-------------------------------------------------+
| slashCommandListener                            |
+-------------------------------------------------+
| - server:Server                                 |
| - user:User                                     |
| - commandId:string                              |
+-------------------------------------------------+
| + onSlashCommand(event:slashCommandEvent): void |
+-------------------------------------------------+
```

**Sequence diagram**<br>
The sequence diagram is made to show the interaction between classes during runtime, it will take an actor from the use case diagram and run a use case through the classes defined in the class diagram.

```
            User                               System
             |                                    |
             |                                    |
             +--------slashCommandReceived------>[ ]
             |                                   [ ]
             |                                   [ ] run(slashCommandEvent)
             |                                   [ ]
             +<-------------response-------------[ ]
             |                                    |
             |                                    |
             |                                    |
```

**Design patterns**<br>
The general design patterns are known as Factories, Singletons, Builders, Commands, Iterators, Adapters, Decorators, they will be descibed below

**Factory**<br>
The factory is used to create object using a shared method without exposing the user to the specifics of the instantiation process, this can most often be seen by having the interface an object implements have a method that instantiates its subclasses.

**Singletons**<br>
The singleton is an object which there may and will only ever be one of in a run of a program, observe the code below:
```java
class singleton{
    private static singleton self = null;
    public singleton(){
        if(self == null) self = this;
        else throw new SingletonException();
    }
}
```
so the object will always only be the one instantiation.

**Builders**<br>
A builder is a class, often a subclass of another class where it takes all the information given in methods of that class and saves them while the attributes are being set, once the build(); method is called the Builder object will return the superclass. an example is shown below:
```java
class SuperClass{
    private String titleFormatted; //empty attribute
    private SuperClass(){} //private constructor to make sure the user always uses the builder

    class Builder{
        private String title = ""
        public Builder(){} //builder constructor doesn't have to be empty
        public Builder setTitle(String title){
            this.title = title;
            return this; //return the builder object so the user can chain method calls
        }
        public SuperClass build(){
            SuperClass class = new SuperClass();
            class.titleFormatted = new Formatter().format(this.title);
            return class;
        }
    }
}
```

**Commands**<br>
A command is usually a way for the user to request something of the software, it is useful to encapsulate the data that the user has added. they usually carry an execute function like in the discord bot example used before, when the discord bot has a class per command the interface they implment has an execute method that calls a run method that the implementing class must implement. This is where the code to be executed should be.

**Interpreter**<br>
The interpreter is usually a design pattern where it should interpret some language, lets say we have a json interpreter, we should have a way to distinguish between strings and integers and other json objects in the interpreter. The interpreter could also be used to execute code, take an example like jython, it takes code defined in java as a string and passes it to the library's interpreter which executes the code.

**Iterator**<br>
an iterator provides access to a sequential object without exposing the representation of the object, in java an object could implement the iterable interface and thus be usable in a for loop.

**Adapter**<br>
An adapter would be a class used to convert some data from a command or request into using an otherwise incompatible method. Lets say a command was used in a discord bot, the command should execute the corresponding feature class's execute method, but it can not call that directly, therefore an adapter is used between these two classes. in the discord bot a class called `ListenerAdapter` is used as an eventlistener.

**Decorator**<br>
A dynamic keyword added to some objects that changes some of its behavior, in java it is usually used to change how warnings are perceived in the editor or how the editor should interpret a block of code, say the @SuppressWarnings decorator is used, it would ignore all warnings for this 




# Implementation
**Polymorphism**<br>
polymorphism is basicly the same concept as overloading, but can also refer to subclasses, or inheritance

**Encapsulation**<br>
Encapsulation is when the data is hidden within an object, in java this can be done in two different ways, you can have a protected attribute, which means the class is available to subclasses, but not other classes. you can also have a private attribute, this is an attribute where its only the defining class that can access the attribute.

**Abstraction**<br>
Here we make a class, put all implementation specifics of that feature into that class and forget about the specifics of this implementation. This is very useful to focus on the implementation in progress and leave the required functionality to be implemented after implementing what needs it.

**coding practises**<br>
I like to use camel case when i use java, it is the default and it usually looks very good and tidy.

limit the functionality of a class

**databases and serialization**<br>
contrary to the lectures i would like to avoid the word "pickle" because pickle is a python term for serialization, the correct term is serialization.

Serialization is a way to serialize an object into a string of data, it is very useful to save data for a later run of the software, it can be used as an alternative to a database or a configuration file, because the program can just use serialization to cache the current state of the program.

A database is usually very useful for storing userdata or simulation data or something like that, there are many types of databases, most often i just use json, but SQL is also often very useful. SQL stores data in tables that are easy to read both by the human eye and by a program.

**documentation**<br>
for documentation, we used java so we used the javadoc documentation method, it is usually placed just before the method and follows a very neat syntax that is easy to read and write.

**GUI**<br>
The gui in python i usually use is PyQt6, it is a good library.

I will use my work's GUI as an example:
<image src=/home/mast3r/git/notes/5th_semester/OOADI/gui1.png>
this is the main runner it is built upon layouts, the layouts are highlighted below:
<image src=/home/mast3r/git/notes/5th_semester/OOADI/gui3.png>
where the red box shows a vertical layout, with two elements, a button saying "start" and a horizontal layout in the green box. the green box contains a horizontal layout with 4 vertical layouts in it. The blue box is one of the vertical layouts, it contains two items: a label containing the string "Lecture" and a selection box with lecture numbers on it.

<image src=/home/mast3r/git/notes/5th_semester/OOADI/gui2.png>
lastly there is the main GUI, it has two tabs, buttons at the bottom and a log on the side. it follows the same type of box layout as above, but the log has a limited size and the main window is scaled accordingly.