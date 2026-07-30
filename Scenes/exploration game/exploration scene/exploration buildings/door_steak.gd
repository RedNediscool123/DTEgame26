extends Area2D
@export var resume_anchor: String = "food_found_steak"
func _ready() -> void:
	body_entered.connect(_on_body_entered)
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameState.dialog_anchor = resume_anchor
		call_deferred("change_scene", "res://Scenes/text game/main_game.tscn")
func change_scene(path: String) -> void:
	get_tree().change_scene_to_file(path)
