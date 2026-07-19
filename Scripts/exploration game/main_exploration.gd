extends Node2D

@onready var music_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	music_player.play()
	music_player.finished.connect(music_player.play)
