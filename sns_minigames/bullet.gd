extends CharacterBody2D

@export var dmg = 10

func _process(_delta: float) -> void:
	$".".rotate(get_angle_to($".".position+velocity))
	velocity += Vector2(0,15)
	move_and_slide()
	if $".".position.y > 2000:
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_parent().name == "targets":
		body.del(0.1)
		$"..".score += 1
		velocity *= 0.7
		$"..".get_child(8).add()
	elif body is CharacterBody2D and body.name == 'plr':
		body.dmgd(dmg,position)
	elif body is StaticBody2D:
		queue_free()
	print(body)
