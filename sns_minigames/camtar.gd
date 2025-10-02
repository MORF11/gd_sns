extends Node2D

var sp = 3

func _physics_process(delta: float) -> void:
	if position.distance_to($"../CharacterBody2D".position) != 0:
		if position.distance_to($"../CharacterBody2D".position) > 70:
			position = position.lerp($"../CharacterBody2D".position,4*delta)


func _on_button_button_down() -> void:
	$"..".get_parent()._on_quit_button_down()
