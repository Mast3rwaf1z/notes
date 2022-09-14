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
