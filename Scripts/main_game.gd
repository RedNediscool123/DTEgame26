extends Node2D

@onready var character = %Lizard
@onready var dialogui = %DialogUI
@onready var sound_player = $AudioStreamPlayer

var dialog_index: int = 0
var dialogue_text: Array = []

func _ready():
	dialogue_text = load_dialog("res://Assets/Story/story.json")
	dialog_index = 0
	process_current_line()

func _input(event):
	if event.is_action_pressed("next_line"):
		if dialogui.animate_text:
			dialogui.skip_text_animation()
		else:
			if dialog_index < len(dialogue_text) - 1:
				dialog_index += 1
				process_current_line()

func load_dialog(file_path):
	if not FileAccess.file_exists(file_path):
		printerr("File does not exist: ", file_path)
		return []
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file == null:
		printerr("Error: failed to open the file: ", file_path)
		return []
	var content = file.get_as_text()
	var json_content = JSON.parse_string(content)
	if json_content == null:
		printerr("Failed to parse JSON from file: ", file_path)
		return []
	return json_content

func process_current_line():
	var line_info = dialogue_text[dialog_index]
	dialogui.change_line(line_info["speaker"], line_info["text"])
	character.change_character(line_info["speaker"])
	if line_info.has("sound"):
		sound_player.stream = load(line_info["sound"])
		sound_player.play()
