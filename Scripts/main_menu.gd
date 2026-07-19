extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	preload("res://Assets/sound_effects/nintendo-game-boy-startup.mp3")
	preload("res://Assets/sound_effects/the-family-feud-buzzer-sound-effect.mp3")
	%AudioStreamPlayer2D.play()







func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://Scenes/exploration game/exploration scene/main_exploration.tscn")



func _on_options_pressed() -> void:
	pass # Replace with function body.




func _on_quit_pressed():
	get_tree().quit()
