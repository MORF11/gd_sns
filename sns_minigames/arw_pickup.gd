extends Area2D

@onready var c = $"../../../camtar/Camera2D/arws"

func _on_body_entered(body: Node2D) -> void:
	if body.name != 'plr':
		return
	$"../AnimationPlayer".play("pickup")
	await get_tree().create_timer(1.3).timeout
	c.visible = true
	c.modulate.a = 0
	await get_tree().create_timer(0.1).timeout
	c.modulate.a = 0.5
	await get_tree().create_timer(0.2).timeout
	c.modulate.a = 1
	$"..".queue_free()
