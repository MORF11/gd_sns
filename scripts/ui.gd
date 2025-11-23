extends Control

var sh = preload("res://scenes/shield.tscn")
var mg = preload("res://scenes/magic.tscn")
var bw = preload("res://scenes/bow.tscn")
var sw = preload("res://scenes/sword.tscn")
var pl = preload("res://scenes/pltfrmr.tscn")
var ht = preload("res://scenes/howto.tscn")
var is_inv = false
@export var ml = 0
@export var rn = 0
@export var ult = 0
@export var hp = 0
var slctdmg = 'no'

func _ready() -> void:
	$lvl.text = str(glb.level)
	$hp.text = str(glb.max_hp)
	$rn.text = str(glb.max_rn)
	$mg.text = str(glb.max_ult)
	$ml.text = str(glb.max_ml)


func _on_shield_button_down() -> void:
	glb.ch_sc("res://scenes/shield.tscn")


func _on_magic_button_down() -> void:
	glb.ch_sc("res://scenes/magic.tscn")


func _on_bow_button_down() -> void:
	glb.ch_sc("res://scenes/bow.tscn")


func _on_sword_button_down() -> void:
	glb.ch_sc("res://scenes/sword.tscn")


func _on_play_button_down() -> void:
	glb.ch_sc("res://scenes/pltfrmr.tscn")
	


func _on_howto_button_down() -> void:
	glb.ch_sc("res://scenes/howto.tscn")
