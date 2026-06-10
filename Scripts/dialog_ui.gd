extends Control

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
	#create a new button for each choice
	for choice in choices:
		var choice_button = ChoiceButtonScene.instantiate()
		choice_button.text = choice["text"]
		choice_button.modulate = Color(1, 0, 0)
		# add the button to choices container
		choice_list.add_child(choice_button)
		
	#show the choice list
	choice_list.show()
	




func skip_text_animation():
	dialogue_text.visible_ratio = 1
