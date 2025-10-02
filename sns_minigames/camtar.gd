extends Node2D

var sp = 3

func _physics_process(delta: float) -> void:
	if position.distance_to($"../CharacterBody2D".position) != 0:
		if position.distance_to($"../CharacterBody2D".position) > 70:
			position = position.lerp($"../CharacterBody2D".position,4*delta)
	$"..".get_parent().get_child(5).position = Vector2(position.x+500,position.y-300)
