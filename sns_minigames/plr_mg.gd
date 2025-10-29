extends CharacterBody2D

var sp = 3500
var tar = preload("res://target.tscn")
@export var score = 0
@export var max_score = 0
var fr = 0
var trg

func _ready() -> void:
	$"../max_score".text = str(max_score)
	$"../score".text = "0"


func do_movement(delta):
	var ms = get_global_mouse_position()
	var pos = $".".position
	velocity += pos.direction_to(ms) * sp * delta
	velocity *= 0.98
	move_and_slide()


func loose():
	score = 0
	$"../score".text = str(score)
	for c in $"../targets".get_children():
		c.del(0.1)


func _process(delta: float) -> void:
	do_movement(delta)
	fr += 1
	if fr % 70 == 0:
		trg = tar.instantiate()
		trg.position = Vector2(randi()%1000+500,randi()%600+100)
		if score > 100:
			trg.time = 3.5
		elif score > 200:
			trg.time = 3
		elif score > 300:
			trg.time = 2.7
		trg.get_child(1).connect('timeout',loose)
		$"../targets".add_child(trg)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is StaticBody2D:
		body.del(0.05)
		$"../lvl".add()
		score += 1
		$"../score".text = str(score)
		if score > max_score:
			max_score = score
			$"../max_score".text = str(max_score)
