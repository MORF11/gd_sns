extends Node2D

var ar = preload("res://arrow.tscn")
var ar_ins
var string = 0
var power = 3000

func _process(_delta: float) -> void:
	$".".rotate(get_angle_to(get_global_mouse_position()))
	$"../Head".rotate($"../Head".get_angle_to(get_global_mouse_position()))
	queue_redraw()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.is_pressed():
		if string > 20:
			ar_ins = ar.instantiate()
			ar_ins.position = $Bow.global_position
			ar_ins.velocity = Vector2(cos($".".rotation),sin($".".rotation))*power
			$"..".add_child(ar_ins)
		string = 0
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		if string <= 20:
			string += 1


func _draw() -> void:
	draw_line(Vector2(230,-200), Vector2(300-(string*7),-75) , Color.BLACK, 4)
	draw_line(Vector2(300-(string*7),-75), Vector2(370,50) , Color.BLACK, 4)
