extends Node2D

var ar = preload("res://arrow.tscn")
@export var score = 0
var tar = preload("res://target.tscn")
var trt
var fr = 0

func loose():
	score = 0
	for c in $"targets".get_children():
		c.del(0.1)


func _process(_delta: float) -> void:
	fr += 1
	if fr % 70 == 0:
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
