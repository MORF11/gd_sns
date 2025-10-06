extends Node2D

var main = preload("res://main.tscn")
var ap = preload("res://apple.tscn")
var c = 0
@export var hits = 0
var ins
var points = []
var spray
var turn
var leng
var q

func spawn(pos):
	ins = ap.instantiate()
	ins.is_spawned = true
	ins.position = points[pos]
	add_child(ins)
	c = 0


func _ready() -> void:
	q = 3.1415/180
	for i in range(88):
		$"../rot".rotate(0.5)
		points.append($"../rot/Icon".global_position)
	for i in range(100):
		print()


func _process(_delta: float) -> void:
	c += 1
	if (c % 30 if hits < 150 else c % 15) != 0:
	#if c % 40-int((hits+1)/10) != 0:
		return
	if randi()%15 != 0:
		spawn(randi()%88)
	else:
		spray = randi()%88
		leng = randi()%30+1
		turn = randi()%leng
		for i in range(turn):
			spawn(spray)
			spray += 1
			if spray > 87:
				spray = 0
			await get_tree().create_timer(0.15).timeout
		for i in range(leng-turn):
			spawn(spray)
			spray -= 1
			if spray > 87:
				spray = 0
			await get_tree().create_timer(0.15).timeout


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		hits = 0
		body.queue_free()
