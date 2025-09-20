extends Control

var sh = preload("res://shield.tscn")
var mg = preload("res://magic.tscn")
var bw = preload("res://bow.tscn")
var sw = preload("res://sword.tscn")
var is_inv = false

func inv():
	var q = $".".get_children()
	if not is_inv:
		for c in q:
			c.visible = false
	else:
		for c in q:
			c.visible = true
	$quit.visible = false
	if not is_inv:
		$quit.visible = true
	
	is_inv = not is_inv


func _on_quit_button_down() -> void:
	inv()
	for c in $".".get_children():
		if c is Node2D:
			c.queue_free()


func _on_shield_button_down() -> void:
	inv()
	add_child(sh.instantiate())


func _on_magic_button_down() -> void:
	inv()
	add_child(mg.instantiate())


func _on_bow_button_down() -> void:
	inv()
	add_child(bw.instantiate())


func _on_sword_button_down() -> void:
	inv()
	add_child(sw.instantiate())
