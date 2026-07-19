extends CharacterBody2D
const SPEED = 75
var last_direction: Vector2 = Vector2.RIGHT
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var min_bounds: Vector2 = Vector2(0, 0)
@export var max_bounds: Vector2 = Vector2(1152, 648)
@export var half_size: Vector2 = Vector2(16, 16)  # adjust to match your sprite's half-width/height

func _physics_process(_delta: float) -> void:
	
	process_movement()
	process_animation()
	move_and_slide()
	clamp_to_bounds()

func process_movement() -> void:
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_vector("left", "right", "up", "down")
	
	if direction != Vector2.ZERO:
		last_direction = direction
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
	
func process_animation() -> void:
	if velocity != Vector2.ZERO:
		play_animation("run", last_direction)
	else:
		play_animation("idle", last_direction)

func play_animation(prefix: String, dir: Vector2) -> void:
	if dir.x != 0:
		animated_sprite_2d.flip_h = dir.x < 0
		animated_sprite_2d.play(prefix + "_right")
	elif dir.y < 0:
		animated_sprite_2d.play(prefix + "_up")
	elif dir.y > 0:
		animated_sprite_2d.play(prefix + "_down")

func clamp_to_bounds() -> void:
	position.x = clamp(position.x, min_bounds.x + half_size.x, max_bounds.x - half_size.x)
	position.y = clamp(position.y, min_bounds.y + half_size.y, max_bounds.y - half_size.y)
