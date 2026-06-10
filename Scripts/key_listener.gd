extends Sprite2D

@onready var falling_key = preload("res://Scenes/falling_keys.tscn")
@export var key_name: String = ""

var falling_key_queue = []





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if falling_key_queue.size() > 0:
		if Input.is_action_just_pressed(key_name):
			# find the key closest to pass_threshold
			var closest = falling_key_queue[0]
			for key in falling_key_queue:
				if abs(key.global_position.y - key.pass_threshold) < abs(closest.global_position.y - closest.pass_threshold):
					closest = key
			falling_key_queue.erase(closest)
			var distance_from_pass = abs(closest.pass_threshold - closest.global_position.y)
			RhythmGameSignals.IncrementScore.emit(100)
			closest.queue_free()
		elif falling_key_queue.front().has_passed:
			falling_key_queue.pop_front()

	
	
	



func CreateFallingKey():
	var fk_inst = falling_key.instantiate()
	get_tree().get_root().add_child(fk_inst)
	fk_inst.Setup(position.x, frame + 4)
	
	falling_key_queue.push_back(fk_inst)


func _on_random_spawn_keys_timeout():
	CreateFallingKey()
	$RandomSpawnTimer.wait_time = randf_range(0.4, 3)
	$RandomSpawnTimer.start()
