extends Node2D

@onready var animated_sprite = $AnimatedSprite2D

func _ready() -> void:
	pass

func change_character(character_name: String):
	animated_sprite.play(character_name)
