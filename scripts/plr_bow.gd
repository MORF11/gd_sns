extends Node2D

var ar = preload("res://scenes/arrow.tscn")
@export var score = 0
@export var max_score = glb.max_rn
var tar = preload("res://scenes/target.tscn")
var trt
var fr = 0
var t = 1

func _ready() -> void:
	$max_score.text = str(max_score)
	$score.text = "0"
	while true:
		await get_tree().create_timer(t).timeout
		t -= 0.002
		trt = tar.instantiate()
		trt.position = Vector2(randi()%1000+500,randi()%600+100)
		if score > 100:
			trt.time = 5.5
		elif score > 200:
			trt.time = 4.5
		elif score > 300:
			trt.time = 4
		trt.get_child(1).connect('timeout',loose)
		$"targets".add_child(trt)


func loose():
	score = 0
	$score.text = "0"
	for c in $"targets".get_children():
		c.del(0.1)


func _on_quit_button_down() -> void:
	glb.max_rn = max(max_score,glb.max_rn)
	glb.save_dt('rn',glb.max_rn)
	glb.save_dt('lv',glb.level)
	glb.qw()
