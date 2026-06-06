extends Node2D

@onready var character = %Lizard
@onready var dialogui = %DialogUI

var dialog_index : int = 0


const dialogue_text : Array[String] = [
	"Lizard: Hello, nice to finally meet you, press enter or space, or just click to continue", 
	"Lizard: Wow! you're getting the hang of this already!"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	#Process first line of dialogue.
	dialog_index = 0
	process_current_line()

func _input(event):
	if event.is_action_pressed("next_line"):
		if dialog_index < len(dialogue_text) - 1:
			dialog_index += 1
			process_current_line()




func parse_line(line: String):
	var line_info = line.split(":")
	assert(len(line_info) >= 2)
	return {
		"speaker_name": line_info[0] , 
		"dialogue_text": line_info[1]
	}
	
func process_current_line():
	var line = dialogue_text[dialog_index]
	var line_info = parse_line(line)
	dialogui.speaker_name.text = line_info["speaker_name"]
	dialogui.dialogue_text.text = line_info["dialogue_text"]
	
