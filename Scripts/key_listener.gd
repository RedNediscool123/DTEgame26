extends Sprite2D
@onready var falling_key = preload("res://Scenes/falling_keys.tscn")
@onready var score_text = preload("res://Scenes/score_press_text.tscn")
@export var key_name: String = ""
# If distance_from_pass is less than threshold, give that score
var perfect_press_threshold: float = 30
var great_press_threshold: float = 50
var good_press_threshold: float = 60
var ok_press_threshold: float = 80
# otherwise, miss
var perfect_press_score: float = 250
var great_press_score: float = 100
var good_press_score: float = 50
var ok_press_score: float = 20
var falling_key_queue = []
# Called when the node enters the scene tree for the first time.
func _ready():
	RhythmGameSignals.CreateFallingKey.connect(CreateFallingKey)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed(key_name):
		RhythmGameSignals.KeyListenerPress.emit(key_name, frame)
	
	#make sure there is a falling key to check for this given key
	if falling_key_queue.size() > 0:
		if Input.is_action_just_pressed(key_name):
			# find the key closest to pass_threshold
			var closest = falling_key_queue[0]
			for key in falling_key_queue:
				if abs(key.global_position.y - key.pass_threshold) < abs(closest.global_position.y - closest.pass_threshold):
					closest = key
			falling_key_queue.erase(closest)
			var distance_from_pass = abs(closest.pass_threshold - closest.global_position.y)
			
			var st_inst_text = "MISS"
			if distance_from_pass < perfect_press_threshold:
				RhythmGameSignals.IncrementScore.emit(perfect_press_score)
				st_inst_text = "PERFECT"
				RhythmGameSignals.IncrementCombo.emit()
			elif distance_from_pass < great_press_threshold:
				RhythmGameSignals.IncrementScore.emit(great_press_score)
				st_inst_text = "GREAT"
				RhythmGameSignals.IncrementCombo.emit()
			elif distance_from_pass < good_press_threshold:
				RhythmGameSignals.IncrementScore.emit(good_press_score)
				st_inst_text = "GOOD"
				RhythmGameSignals.IncrementCombo.emit()
			elif distance_from_pass < ok_press_threshold:
				RhythmGameSignals.IncrementScore.emit(ok_press_score)
				st_inst_text = "OK"
				RhythmGameSignals.IncrementCombo.emit()
			else:
				# MISS
				RhythmGameSignals.ResetCombo.emit()
			
			var st_inst = score_text.instantiate()
			get_tree().get_root().call_deferred("add_child", st_inst)
			st_inst.global_position = global_position
			st_inst.set_text(st_inst_text)
			
			closest.queue_free()
		elif falling_key_queue.front().has_passed:
			falling_key_queue.pop_front()
	
	
	
func CreateFallingKey(button_name: String):
	if button_name == key_name:
		var fk_inst = falling_key.instantiate()
		get_tree().get_root().add_child(fk_inst)
		fk_inst.Setup(position.x, frame + 4)
		falling_key_queue.push_back(fk_inst)
func _on_random_spawn_keys_timeout():
	#CreateFallingKey()
	$RandomSpawnTimer.wait_time = randf_range(0.4, 3)
	$RandomSpawnTimer.start()
