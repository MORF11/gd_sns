extends Node2D

var ap = preload("res://scenes/apple.tscn")
var c = 0
@export var score = 0
@export var max_score = glb.max_hp
var t = 1
var ins
var points = []
var spray
var turn
var leng
var cond

func spawn(pos):
	ins = ap.instantiate()
	ins.is_spawned = true
	ins.position = points[pos]
	add_child(ins)
	c = 0


func tm(time):
	await get_tree().create_timer(time).timeout


func _ready() -> void:
	$max_score.text = str(max_score)
	$score.text = "0"
	for i in range(88):
		$"../rot".rotate(0.5)
		points.append($"../rot/Icon".global_position)
	while true:
		await tm(t)
		t -= 0.002
		if randi()%30 != 0:
			spawn(randi()%88)
		else:
			spray = randi()%88
			leng = randi()%12+1
			turn = randi()%leng
			for i in range(turn):
				spawn(spray)
				spray += 1
				if spray > 87:
					spray = 0
				await tm(0.15)
			for i in range(leng-turn):
				spawn(spray)
				spray -= 1
				if spray > 87:
					spray = 0
				await tm(0.15)


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		score = 0
		$score.text = "0"
		body.queue_free()


func _on_quit_button_down() -> void:
	glb.max_hp = max(max_score,glb.max_hp)
	glb.save_dt('sh',glb.max_hp)
	glb.save_dt('lv',glb.level)
	glb.qw()
