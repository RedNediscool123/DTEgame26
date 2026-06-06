extends Control

@onready var dialogue_text = %dialogue_text
@onready var speaker_name = %speaker_name

const ANIMATION_SPEED : int = 30
var animate_text : bool = false
var current_visible_characters : int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta):
	if animate_text:
		if dialogue_text.visible_ratio < 1:
			dialogue_text.visible_ratio += (1.0/dialogue_text.text.length()) * (ANIMATION_SPEED * delta)
			current_visible_characters = dialogue_text.visible_characters
		else:
			animate_text = false



func change_line(speaker : String, line : String):
	speaker_name.text = speaker
	current_visible_characters = 0
	dialogue_text.text = line
	dialogue_text.visible_characters = 0
	animate_text = true
	
func skip_text_animation():
	dialogue_text.visible_ratio = 1
