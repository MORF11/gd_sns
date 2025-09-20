extends Node2D

func _process(_delta: float) -> void:
	$".".rotate(get_angle_to(get_global_mouse_position()))


func _on_shield_body_entered(body: Node2D) -> void:
	body.queue_free()
	$"..".hits += 1
	$shield/Icon.position.x -= 5
	await  get_tree().create_timer(0.05).timeout
	$shield/Icon.position.x -= 5
	await  get_tree().create_timer(0.05).timeout
	$shield/Icon.position.x += 10
