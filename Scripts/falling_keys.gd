extends Sprite2D


@export var fall_speed: float = 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2(0, fall_speed)
