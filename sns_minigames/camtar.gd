extends Node2D

var sp = 3

func _process(_delta: float) -> void:
	if position.distance_to($"../CharacterBody2D".position) != 0:
		if position.distance_to($"../CharacterBody2D".position) > 70:
			sp = 7
		else:
			sp = 5
		position.x = move_toward(position.x,$"../CharacterBody2D".position.x,sp)
		position.y = move_toward(position.y,$"../CharacterBody2D".position.y,sp)
		$"..".get_parent().get_child(5).position = Vector2(position.x+500,position.y-300)
		print(sp)
