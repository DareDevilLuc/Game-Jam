extends Node

var anomalyCtr = 0
var heartHealth = 3
func reset():
	anomalyCtr = 0

func add_anomaly():
	anomalyCtr += 1

func heartbreak():
	heartHealth -= 1


	
