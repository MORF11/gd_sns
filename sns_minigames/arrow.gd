extends CharacterBody2D

func _process(_delta: float) -> void:
	$".".rotate(get_angle_to($".".position+velocity))
	velocity += Vector2(0,15)
	move_and_slide()
	if $".".position.y > 2000:
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is StaticBody2D:
		body.del(0.1)
		$"..".score += 1
		velocity *= 0.7
		$"..".get_child(4).add()
