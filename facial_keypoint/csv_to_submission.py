import csv
import json

data = []
with open('solution_4factor_1pass.csv', 'r') as f:
	reader = csv.reader(f, delimiter=',')
	i = 1
	for row in reader:
		data.append(row)

