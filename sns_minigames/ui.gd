extends Control

var sh = preload("res://shield.tscn")
var mg = preload("res://magic.tscn")
var bw = preload("res://bow.tscn")
var sw = preload("res://sword.tscn")
var pl = preload("res://pltfrmr.tscn")
var ht = preload("res://howto.tscn")
var is_inv = false
var q

func inv(trnng,pltfrmr):
	q = $".".get_children()
	if not is_inv:
		for c in q:
			#if c.name != 'bg' and not pltfrmr:
			c.visible = false
	else:
		for c in q:
			c.visible = true
	$quit.visible = false
	if trnng:
		$lvl.visible = true
	if not is_inv:
		if not pltfrmr:
			$quit.visible = true
		$lvl.visible = false
	is_inv = not is_inv


func _on_quit_button_down() -> void:
	inv(true,false)
	for c in $"./Node2D".get_children():
		c.queue_free()
	$"./Node2D".queue_free()


func _on_shield_button_down() -> void:
	inv(true,false)
	add_child(sh.instantiate())


func _on_magic_button_down() -> void:
	inv(true,false)
	add_child(mg.instantiate())


func _on_bow_button_down() -> void:
	inv(true,false)
	add_child(bw.instantiate())


func _on_sword_button_down() -> void:
	inv(true,false)
	add_child(sw.instantiate())


func _on_play_button_down() -> void:
	inv(false,true)
	add_child(pl.instantiate())
	


func _on_howto_button_down() -> void:
	inv(false,false)
	add_child(ht.instantiate())
