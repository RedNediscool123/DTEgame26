extends Control

signal choice_selected

# preload the player choice scene
const ChoiceButtonScene = preload("res://Scenes/player_choice.tscn")

@onready var dialogue_text = %dialogue_text
@onready var speaker_name = %speaker_name
@onready var choice_list = %ChoiceList
@onready var sound_player = $TextBlipSound

const ANIMATION_SPEED: int = 30
const NO_SOUND_CHARS = [".", ",", "!", "?", ":", ";", "-", "—", "'", "\"", "(", ")", "[", "]", "{", "}"]

var animate_text: bool = false
var current_visible_characters: int = 0

func _ready():
	#hide the choice list
	choice_list.hide()

func _process(delta):
	if animate_text:
		if dialogue_text.visible_ratio < 1:
			dialogue_text.visible_ratio += (1.0 / dialogue_text.text.length()) * (ANIMATION_SPEED * delta)
			if dialogue_text.visible_characters > current_visible_characters:
				current_visible_characters = dialogue_text.visible_characters
				var current_char = dialogue_text.text[current_visible_characters - 1]
				if current_char.strip_edges() != "" and not NO_SOUND_CHARS.has(current_char):
					sound_player.play_character_sound()
		else:
			animate_text = false

func change_line(speaker: String, line: String):
	speaker_name.text = speaker
	current_visible_characters = 0
	dialogue_text.text = line
	dialogue_text.visible_characters = 0
	animate_text = true
	

func display_choices(choices: Array):
	#clear any existing choices
	for child in choice_list.get_children():
		child.queue_free()
	
	for child in choice_list.get_children():
		child.queue_free()

	for choice in choices:
		var choice_button = ChoiceButtonScene.instantiate()
		choice_button.text = choice["text"]
		choice_button.modulate = Color(1, 0, 0)
		# Attach signal to the choice
		choice_button.pressed.connect(_on_choice_button_pressed.bind(choice["goto"]))
		
		
		#add a child instead of copying previous choices
		choice_list.add_child(choice_button)

	choice_list.show()
	
	# wait one frame so sizes are updated, then center
	await get_tree().process_frame
	choice_list.position.x = (get_viewport_rect().size.x - choice_list.size.x) / 2
	




func skip_text_animation():
	dialogue_text.visible_ratio = 1



func _on_choice_button_pressed(anchor: String):
	choice_selected.emit(anchor)
	choice_list.hide()
