extends CharacterBody2D

var alive = true

func _ready():
	if not alive:
		print("jo")
