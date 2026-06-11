extends Node2D

func _ready():
	$AudioStreamPlayer2D2.play()
	$AudioStreamPlayer2D2.volume_db = -10
