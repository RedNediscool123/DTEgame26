extends Area2D
@export var target_scene: String = "res://scenes/next_scene.tscn"
@export var resume_anchor: String = "chips_found"
func _ready() -> void:
	body_entered.connect(_on_body_entered)
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameState.dialog_anchor = resume_anchor
		call_deferred("change_scene", "res://Scenes/exploration game/exploration scene/exploration levels/food_forage_pizza.tscn")
func change_scene(path: String) -> void:
	get_tree().change_scene_to_file(path)
