import json
from sys import argv

month = argv[1]

with open("work/workhours.json") as file:
	result = 0
	data = json.loads(file.read())
	if month == "all":
		for month in data:
			for day in data[month]:
				result += float(data[month][str(day)]["duration"])
	else:
		for day in data[month]:
			result += float(data[month][str(day)]["duration"])

print(f'Hours worked: {result}')