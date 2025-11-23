extends RigidBody2D

@export var dmg = 0
var vel

func _ready() -> void:
	vel = Vector2(randi()%300,randi()%800+200)
	if int(vel.x) % 2 == 0:
		vel.x *= -1
	vel.y *= -1
	linear_velocity = vel
	$Label.text = str(dmg)
	$Label.modulate.r += dmg #ne rabotaet chznh

func _on_timer_timeout() -> void:
	for i in range(10):
		$".".modulate.a -= 0.1
		await get_tree().create_timer(0.03).timeout
	queue_free()
