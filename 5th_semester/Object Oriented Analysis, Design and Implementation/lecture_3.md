# exercise

## 1
```
class smartphone:
screen
sd card holder
ram speed
cpu speed
os
model number
serial number
bootloader

objects:
screen
sd card holder
os 
bootloader

    
```
<image src=class_diagram.png>

## 2

<image src=lecture_3.jpg>

## 3

```python
class Dog:
    def __init__(self, name, age):
        self.name = name
        self.age = age
    def play_dead(self):
        print(f'prepare the camera, {self.name} is playing dead')
    
    def get_name(self):
        return self.name

    
mydog = Dog("mydog", 3)
print(f'my dog has the name {mydog.get_name()}')
mydog.play_dead()
print(dir(mydog))
print(mydog)

```