extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player2":
		get_tree().call_deferred("change_scene_to_file", "res://Scenes/text game/grief_route.tscn")
