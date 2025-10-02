extends CharacterBody2D

var dmg = 10
var side = -1 if randi()%2 == 1 else 1

func _physics_process(delta: float) -> void:
	if abs(velocity.x) < 200:
		velocity.x += 500*side*delta
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.collision_layer == 2 or body.collision_layer == 4:
		side *= -1
