extends Node2D

func _ready() -> void:
	%Restart.pressed.connect(_on_restart_pressed)
	%Quit.pressed.connect(_on_quit_pressed)

func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
