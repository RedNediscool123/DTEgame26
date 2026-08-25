extends Node2D

@onready var audio_player: AudioStreamPlayer2D = %AudioStreamPlayer2D

func _ready() -> void:
	audio_player.play()
	audio_player.finished.connect(_on_audio_finished)

func _process(delta: float) -> void:
	pass

func _on_audio_finished() -> void:
	audio_player.play()
