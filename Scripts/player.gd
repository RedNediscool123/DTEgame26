extends CharacterBody2D


const SPEED = 100.0

func _physics_process(delta: float) -> void:
	move_and_slide()
	process_movement()



func process_movement() -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("left" , "right" , "up" , "down")
	
	velocity = direction * SPEED

func play_animation(dir: vector2) -> void:
	if dir.x > 0:
		
