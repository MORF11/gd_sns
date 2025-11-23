extends CharacterBody2D

var sp = 3500
var fr = 0

func _process(delta: float) -> void:
	var ms = get_global_mouse_position()
	var pos = $".".position
	velocity += pos.direction_to(ms) * sp * delta
	velocity *= 0.98
	move_and_slide()
