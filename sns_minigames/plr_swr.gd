extends Area2D

var ap = preload("res://apple.tscn")
@export var score = 0
var fr = 0
var ins
var points = [Vector2(500,0),
Vector2(-500,0),
Vector2(0,-500)]

func spawn(pos):
	ins = ap.instantiate()
	ins.is_spawned = true
	ins.position = points[pos]
	print(ins.position)
	add_child(ins)
	fr = 0


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		score = 0
		body.queue_free()


func _process(_delta: float) -> void:
	fr += 1
	
	if (fr % 30 if score < 100 else fr % 10) != 0:
		return
	spawn(randi()%3)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left"):
		pass
	elif event.is_action_pressed("right"):
		pass
	elif event.is_action_pressed("up"):
		pass
