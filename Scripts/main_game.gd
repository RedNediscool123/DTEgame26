extends Node2D

@onready var character = %Lizard
@onready var dialogui = %DialogUI
@onready var sound_player = $AudioStreamPlayer

var dialog_index: int = 0

const dialogue_text: Array[String] = [
	"Lizard: !!!!!!!!!!!", 
	"Lizard: Hello there! I'm here! over here, I'm just a bit small",
	"Lizard: Hello, nice to finally meet you, press enter or space, or just click to continue",
	"Lizard: Wow! you're getting the hang of this already!",
	"Lizard: You're probably wondering why you're here, aren't you?",
	"Lizard: Well I can tell you! In fact i'd be happy to tell you",
	"Jelly: HOLD IT! [sound:res://Assets/sound_effects/crash_5mE1q2P.mp3]",
	"Lizard: JELLY?!",
	"Lizard: DID YOU JUST BREAK THE WINDOW?!", 
	"Jelly: You slimy lizard! I'll get you back this time!",
	"Jelly: ...",
	"Jelly: Wait... Who's that?",
	"Jelly: Ugh! Nevermind! I'll deal with you stupid lizard first!",
	"Jelly: Huh! He's gone already! This can't be!",
	"Jelly: Catch you later, stranger...",
	"Jelly: GET BACK HERE YOU QUADRUPEDAL PEST!!",
	"You: Well that was strange...",
	"Rocky: Hello stranger! Wait.. why are you in our house?",
	"Rocky: Oh well, have you seen a lizard and a jelly person around? I'm kinda looking for them",
]

func _ready():
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

func parse_line(line: String):
	var sound = ""
	var clean_line = line
	if "[sound:" in line:
		var start = line.find("[sound:") + 7
		var end = line.find("]", start)
		sound = line.substr(start, end - start)
		clean_line = line.substr(0, line.find("[sound:")).strip_edges()
	var parts = clean_line.split(":")
	assert(len(parts) >= 2)
	return {
		"speaker_name": parts[0],
		"dialogue_text": parts[1],
		"sound": sound
	}

func process_current_line():
	var line = dialogue_text[dialog_index]
	var line_info = parse_line(line)
	dialogui.change_line(line_info["speaker_name"], line_info["dialogue_text"])
	character.change_character(line_info["speaker_name"])
	if line_info["sound"] != "":
		sound_player.stream = load(line_info["sound"])
		sound_player.play()
