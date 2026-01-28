extends Node

var anomalyCtr = 0
var heartHealth = 3
func reset():
	anomalyCtr = 0

func add_anomaly():
	anomalyCtr += 1

func heartbreak():
	if heartHealth == 1:
		heartHealth = 3
	else: 
		heartHealth -= 1


	
