extends Node2D

var ar = preload("res://arrow.tscn")
@export var score = 0
var ar_ins
var string = 0
var is_pr = false
var tar = preload("res://target.tscn")
var tr
var fr = 0
var power = 2000

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.is_pressed():
		if string > 20:
			ar_ins = ar.instantiate()
			ar_ins.position = $Node2D/staff.global_position
			ar_ins.velocity = Vector2(cos($Node2D.rotation),sin($Node2D.rotation))*power
			add_child(ar_ins)
		is_pr = false
		string = 0
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		is_pr = true


func loose():
	score = 0
	for c in $"targets".get_children():
		c.del(0.1)


func _process(_delta: float) -> void:
	if is_pr:
		string += 1
	if string > 20:
		$Node2D/staff.modulate.b -= 1
		$Node2D/staff.modulate.g -= 1
	if string == 0:
		$Node2D/staff.modulate.b = 1
		$Node2D/staff.modulate.g = 1
	fr += 1
	if fr % 40 == 0:
		tr = tar.instantiate()
		tr.position = Vector2(randi()%700+300,randi()%400+100)
		if score > 100:
			tr.time = 2.1
		elif score > 200:
			tr.time = 1.8
		elif score > 300:
			tr.time = 1.5
		tr.get_child(2).connect('timeout',loose)
		$"targets".add_child(tr)
