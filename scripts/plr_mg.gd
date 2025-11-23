extends Node2D

@export var score = 0
@export var max_score = glb.max_ult
var t = 1
var tar = preload("res://scenes/target.tscn")
var trg

func _ready() -> void:
	$max_score.text = str(max_score)
	$score.text = "0"
	while true:
		await get_tree().create_timer(t).timeout
		t -= 0.002
		trg = tar.instantiate()
		trg.position = Vector2(randi()%1000+500,randi()%600+100)
		if score > 100:
			trg.time = 3.5
		elif score > 200:
			trg.time = 3
		trg.time = 2.7
		trg.get_child(1).connect('timeout',loose)
		$targets.add_child(trg)


func loose():
	score = 0
	$score.text = str(score)
	for c in $targets.get_children():
		c.del(0.1)



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is StaticBody2D:
		body.del(0.05)
		$lvl.add()
		score += 1
		$score.text = str(score)
		if score > max_score:
			max_score = score
			$max_score.text = str(max_score)


func _on_quit_button_down() -> void:
	glb.max_ult = max(max_score,glb.max_ult)
	glb.save_dt('mg',glb.max_ult)
	glb.qw()
