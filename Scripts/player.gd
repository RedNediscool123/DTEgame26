extends CharacterBody2D



const SPEED = 100.0

var last_direction: Vector2 = Vector2.RIGHT


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	move_and_slide()
	process_movement()



func process_movement() -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("left" , "right" , "up" , "down")
	
	velocity = direction * SPEED
	
	process_animation(direction)

func process_animation(direction) -> void:
	if velocity != Vector2.ZERO:
		play_animation("run", direction)
	else: 
		play_animation("idle", direction)

func play_animation(prefix: String, dir: Vector2) -> void:
	if dir.x > 0:
		animated_sprite_2d.play(prefix + "_right")
	elif dir.y < 0:
		animated_sprite_2d.play(prefix + "_up")
	elif dir.y > 0:
		animated_sprite_2d.play(prefix + "_down")
	elif dir.x < 0:
		animated_sprite_2d.play(prefix + "_left")
		
