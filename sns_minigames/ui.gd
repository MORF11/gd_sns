extends Control

var sh = preload("res://shield.tscn")
var mg = preload("res://magic.tscn")
var bw = preload("res://bow.tscn")
var sw = preload("res://sword.tscn")
var pl = preload("res://pltfrmr.tscn")
var pl_ins
var ht = preload("res://howto.tscn")
var is_inv = false
@export var ml = 0
@export var rn = 0
@export var ult = 0
@export var hp = 0
var slctdmg = 'no'

func inv(trnng,pltfrmr):
	if not is_inv:
		for c in $".".get_children():
			c.visible = false
	else:
		for c in $".".get_children():
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
	match slctdmg:
		'sh':
			hp = $"./Node2D/plr".max_score
		'sw':
			ml = $"./Node2D/plr".max_score
		'bw':
			rn = $"./Node2D".max_score
		'mg':
			ult = $"./Node2D/CharacterBody2D".max_score
	slctdmg = 'no'
	$"./Node2D".queue_free()


func _on_shield_button_down() -> void:
	inv(true,false)
	add_child(sh.instantiate())
	slctdmg = 'sh'
	$"./Node2D/plr".max_score = hp


func _on_magic_button_down() -> void:
	inv(true,false)
	add_child(mg.instantiate())
	slctdmg = 'mg'
	$"./Node2D/CharacterBody2D".max_score = ult


func _on_bow_button_down() -> void:
	inv(true,false)
	add_child(bw.instantiate())
	slctdmg = 'bw'
	$"./Node2D".max_score = rn


func _on_sword_button_down() -> void:
	inv(true,false)
	add_child(sw.instantiate())
	slctdmg = 'sw'
	$"./Node2D/plr".max_score = ml


func _on_play_button_down() -> void:
	inv(false,true)
	pl_ins = pl.instantiate()
	pl_ins.stats = {"ml":10+int(ml/10),"rn":10+int(rn/10),"ult":20+int(ult/10),"hp":100+int(hp/10),"is_ar":false}
	add_child(pl_ins)
	


func _on_howto_button_down() -> void:
	inv(false,false)
	add_child(ht.instantiate())
