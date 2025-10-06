extends Node2D

var trgt

func _physics_process(delta: float) -> void:
	if not $"..".has_node("plr"):
		return
	trgt = Vector2($"../plr".position.x,$"../plr".position.y-100)
	if position.distance_to(trgt) != 0:
		if position.distance_to(trgt) > 70:
			position = position.lerp(trgt,3*delta)


func _on_button_button_down() -> void:
	$"..".get_parent()._on_quit_button_down()
