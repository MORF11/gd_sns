extends Node2D

func _process(_delta: float) -> void:
	$".".rotate(get_angle_to(get_global_mouse_position()))
	if rad_to_deg($".".global_rotation) > 100 or rad_to_deg($".".global_rotation) < -80:
		$"../Head".flip_h = true
		$"../Body".flip_h = true
	else:
		$"../Head".flip_h = false
		$"../Body".flip_h = false


func _on_shield_body_entered(body: Node2D) -> void:
	body.queue_free()
	$"..".hits += 1
	$"../../lvl".add()
	$shield/Node2D.position.x -= 5
	await  get_tree().create_timer(0.05).timeout
	$shield/Node2D.position.x -= 5
	await  get_tree().create_timer(0.05).timeout
	$shield/Node2D.position.x += 10
