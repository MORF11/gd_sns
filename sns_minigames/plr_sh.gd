extends Node2D

var main = preload("res://main.tscn")
var ap = preload("res://apple.tscn")
var c = 0
@export var score = 0
@export var max_score = 0
var ins
var points = []
var spray
var turn
var leng
var q
var cond

func spawn(pos):
	ins = ap.instantiate()
	ins.is_spawned = true
	ins.position = points[pos]
	add_child(ins)
	c = 0


func _ready() -> void:
	$max_score.text = str(max_score)
	$score.text = "0"
	q = 3.1415/180
	for i in range(88):
		$"../rot".rotate(0.5)
		points.append($"../rot/Icon".global_position)


func _process(_delta: float) -> void:
	c += 1
	if score < 100:
		cond =  c % 40 != 0
	elif score < 200:
		cond = c % 30 != 0
	else:
		cond = c % 20 != 0
	if cond:
		return
	if randi()%14 != 0:
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
		score = 0
		$score.text = "0"
		body.queue_free()
