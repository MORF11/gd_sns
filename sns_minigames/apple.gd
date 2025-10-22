extends CharacterBody2D

@export var is_spawned = false
@export var sp = 25000
var rot = randi()%10+10

#func die():
	#$GPUParticles2D.emitting = true
	#$".".modulate.a = 0
	#await get_tree().create_timer(1).timeout
	#queue_free()


func _process(delta: float) -> void:
	if is_spawned:
		$".".rotation += deg_to_rad(rot)
		if rad_to_deg($".".rotation) > 360:
			$".".rotation = 0
		velocity = Vector2.ZERO
		velocity = $".".position.direction_to(Vector2.ZERO) * sp * delta
		move_and_slide()
	
