extends Area2D
@export var target_scene: String = "res://scenes/next_scene.tscn"

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		call_deferred("change_scene", "res://Scenes/text game/grief_route.tscn")

func change_scene(path: String) -> void:
	get_tree().change_scene_to_file(path)
