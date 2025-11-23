extends Node2D

func _process(_delta: float) -> void:
	$".".rotate(get_angle_to(get_global_mouse_position()))
	if $shield/Node2D/Shield.global_position > $".".global_position:
		$"../Node2D2".scale.x = 1
	else:
		$"../Node2D2".scale.x = -1


func _on_shield_body_entered(body: Node2D) -> void:
	body.queue_free()
	$"..".score += 1
	$"../score".text = str($"..".score)
	if $"..".score > $"..".max_score:
		$"..".max_score = $"..".score
		$"../max_score".text = str($"..".max_score)
	$"../../lvl".add()
	$shield/Node2D.position.x -= 5
	await  get_tree().create_timer(0.05).timeout
	$shield/Node2D.position.x -= 5
	await  get_tree().create_timer(0.05).timeout
	$shield/Node2D.position.x += 10
