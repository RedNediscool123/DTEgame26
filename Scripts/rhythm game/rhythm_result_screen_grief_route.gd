extends Control
func _ready():
	%AudioStreamPlayer2D.play()
	$ScoreLabel.text = "Score: " + str(RhythmGameSignals.final_score) + " pts"
	$BestComboLabel.text = "Best Combo: " + str(RhythmGameSignals.best_combo) + "x"
	
	$PlayAgainButton.pressed.connect(_on_play_again_pressed)
	$QuitButton.pressed.connect(_on_quit_pressed)
	%DoneButton.pressed.connect(_on_done_pressed)
	
	%DoneButton.visible = RhythmGameSignals.final_score > 75000

func _on_play_again_pressed():
	RhythmGameSignals.final_score = 0
	RhythmGameSignals.best_combo = 0
	get_tree().change_scene_to_file("res://Scenes/rhythm game/rhythm_game_level.tscn")
func _on_quit_pressed():
	RhythmGameSignals.final_score = 0
	RhythmGameSignals.best_combo = 0
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
func _on_done_pressed():
	RhythmGameSignals.final_score = 0
	RhythmGameSignals.best_combo = 0
	get_tree().change_scene_to_file("res://Scenes/text game/main_game.tscn")
