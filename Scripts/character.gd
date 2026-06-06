extends Node2D

@onready var sprite = $AnimatedSprite2D


const CHARACTER_FRAMES = {
	"Lizard": preload("res://Assets/Sprites/TerinIdle-Sheet.png"),
	"Jelly": preload("res://Assets/Sprites/ChatGPT_Image_Jun_4__2026__10_09_55_PM-removebg-preview-removebg-preview.png"),
	"Rocky": preload("res://Assets/Sprites/rock_melon.png"),
	"Mello": preload("res://Assets/Sprites/water_melon.png")
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
