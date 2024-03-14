from random import randint
from pickle import dumps, loads
import sqlite3 as sql
import json as db

class obj:
    a = randint(-10, 10)
    b = randint(-10, 10)


a = obj()
b = obj()

with open("lecture_10.json", "r") as file:
    json = db.loads(file.read())
    l = json["objects"]
    l.append(str(dumps(a)))
    l.append(str(dumps(b)))
    json["objects"] = l

with open("lecture_10.json", "w") as file:
    file.write(db.dumps(json))

with open("lecture_10.json", "r") as file:
    print(loads(bytes(db.loads(file.read())["objects"][0], "utf-8")))