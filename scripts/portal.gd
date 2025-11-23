extends Node2D

@export var to = "res://scenes/howto.tscn"

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name != 'plr':return
	body.stop = true
	body.global_position = global_position
	$CPUParticles2D.amount = 60
	await get_tree().create_timer(1).timeout
	glb.ch_sc(to)
