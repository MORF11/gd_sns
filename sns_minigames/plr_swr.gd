extends Area2D

var ap = preload("res://apple.tscn")
@export var score = 0
var fr = 0
var ins
var points = [Vector2(800,0),
Vector2(-800,0),
Vector2(0,-800)]
var cd = false
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
		$pivot/Sprite2D/Area2D/GPUParticles2D.restart()
		$pivot/Sprite2D/Area2D/GPUParticles2D.global_position = body.global_position
		$"../lvl".add()


func _process(_delta: float) -> void:
	fr += 1
	if (fr % 50 if score < 100 else fr % 30) != 0:
		return
	if randi() % 3 == 0:
		sp_fl = true
	spawn(randi()%3,sp_fl)
	sp_fl = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left") and not cd:
		$"../AnimationPlayer".play("left")
		cd = true
	elif event.is_action_pressed("right") and not cd:
		$"../AnimationPlayer".play("right")
		cd = true
	elif event.is_action_pressed("up") and not cd:
		if $"../Node2D".scale.x == -1:
			$"../AnimationPlayer".play("up_left")
		else:
			$"../AnimationPlayer".play("up_right")
		cd = true


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name != 'idle':
		cd = false
		$"../AnimationPlayer".play("idle")
