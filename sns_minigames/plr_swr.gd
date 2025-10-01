extends Area2D

var ap = preload("res://apple.tscn")
@export var score = 0
var fr = 0
var ins
var points = [Vector2(500,0),
Vector2(-500,0),
Vector2(0,-500)]
var tmng = 0
var cd = 0
var sp_fl = false

func _ready() -> void:
	score = 0


func spawn(pos,fl):
	ins = ap.instantiate()
	ins.is_spawned = true
	ins.position = points[pos]
	add_child(ins)
	if fl:
		ins.sp *= 1.5


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		score = 0
		body.queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		score += 1
		body.queue_free()
		$"../lvl".add()


func _process(_delta: float) -> void:
	if tmng > 5:
		$Area2D.visible = false
		$Area2D/CollisionShape2D.disabled = true
	tmng += 1
	fr += 1
	cd -= 1
	if (fr % 50 if score < 100 else fr % 30) != 0:
		return
	if randi() % 3 == 0:
		sp_fl = true
	spawn(randi()%3,sp_fl)
	sp_fl = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left") and cd <= 0:
		$Area2D.global_rotation = deg_to_rad(180)
		$Area2D.position = Vector2(-142,0)
		$Area2D.visible = true
		$Area2D/CollisionShape2D.disabled = false
		$"../Body".flip_h = true
		$"../Head".flip_h = true
		tmng = 0
		cd = 20
	elif event.is_action_pressed("right") and cd <= 0:
		$Area2D.global_rotation = 0
		$Area2D.position = Vector2(142,0)
		$Area2D.visible = true
		$Area2D/CollisionShape2D.disabled = false
		$"../Body".flip_h = false
		$"../Head".flip_h = false
		tmng = 0
		cd = 20
	elif event.is_action_pressed("up") and cd <= 0:
		$Area2D.global_rotation = deg_to_rad(90)
		$Area2D.position = Vector2(0,-142)
		$Area2D.visible = true
		$Area2D/CollisionShape2D.disabled = false
		tmng = 0
		cd = 20
