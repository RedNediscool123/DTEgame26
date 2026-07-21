extends Node2D
@onready var character = %Lizard
@onready var dialogui = %DialogUI
@onready var sound_player = $AudioStreamPlayer
var dialog_index: int = 0
var dialogue_text: Array = []

func _ready():
	%AudioStreamPlayer2D.play()
	dialogue_text = load_dialog("res://Assets/Story/grief_story.json")
	
	# If we're returning from another scene, restore saved index 
	if GameState.dialog_index > 0:
		dialog_index = GameState.dialog_index
		GameState.dialog_index = 0
	else:
		dialog_index = 0
	
	process_current_line()
	
	# connect signals
	dialogui.choice_selected.connect(_on_choice_selected)

func _input(event):
	var line = dialogue_text[dialog_index]
	var has_choices = line.has("choices")
	if event.is_action_pressed("next_line") and not has_choices:
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
	
	if line_info.has("scene"):
		GameState.dialog_index = dialog_index + 1
		get_tree().change_scene_to_file(line_info["scene"])
		return
	
	if line_info.has("goto"):
		dialog_index = get_anchor_position(line_info["goto"])
		process_current_line()
		return
	
	if line_info.has("anchor"):
		dialog_index += 1
		process_current_line()
		return
	
	if line_info.has("choices"):
		dialogui.display_choices(line_info["choices"])
	else:
		dialogui.change_line(line_info["speaker"], line_info["text"])
		character.change_character(line_info["speaker"])
		if line_info.has("sound"):
			sound_player.stream = load(line_info["sound"])
			sound_player.play()

func get_anchor_position(anchor: String):
	for i in range(dialogue_text.size()):
		if dialogue_text[i].has("anchor") and dialogue_text[i]["anchor"] == anchor:
			return i
	printerr("Error: could not find anchor '" + anchor + "'")
	return null

func _on_choice_selected(anchor: String):
	dialog_index = get_anchor_position(anchor)
	process_current_line()
