extends CharacterBody2D

const SPEED = 100.0
var last_direction: Vector2 = Vector2.RIGHT



@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	

	
	
	move_and_slide()
	process_movement()

func process_movement() -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	velocity = direction * SPEED
	process_animation(direction)

func process_animation(direction: Vector2) -> void:
	if direction != Vector2.ZERO:
		last_direction = direction  # Update last direction while moving
		play_animation("run", direction)

func play_animation(prefix: String, dir: Vector2) -> void:
	if dir.x > 0:
		animated_sprite_2d.play(prefix + "_right")
	elif dir.x < 0:
		animated_sprite_2d.play(prefix + "_left")
	elif dir.y < 0:
		animated_sprite_2d.play(prefix + "_up")
	elif dir.y > 0:
		animated_sprite_2d.play(prefix + "_down")
		
		
		


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("In")
	var alive = false
