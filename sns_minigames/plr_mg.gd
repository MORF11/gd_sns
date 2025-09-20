extends CharacterBody2D

var sp = 3500
var tar = preload("res://target.tscn")
@export var score = 0
var fr = 0
var tr

func do_movement(delta):
	var ms = get_global_mouse_position()
	var pos = $".".position
	velocity += pos.direction_to(ms) * sp * delta
	velocity *= 0.98
	move_and_slide()


func loose():
	score = 0
	for c in $"../targets".get_children():
		c.del(0.1)


func _process(delta: float) -> void:
	do_movement(delta)
	fr += 1
	if fr % 40 == 0:
		tr = tar.instantiate()
		tr.position = Vector2(randi()%700+300,randi()%400+100)
		if score > 100:
			tr.time = 2.1
		elif score > 200:
			tr.time = 1.8
		elif score > 300:
			tr.time = 1.5
		tr.get_child(2).connect('timeout',loose)
		$"../targets".add_child(tr)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is StaticBody2D:
		body.del(0.05)
		score += 1
