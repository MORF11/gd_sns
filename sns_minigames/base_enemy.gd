extends CharacterBody2D

var damage = 10
var hp = 100
var side = -1 if randi()%2 == 1 else 1

func dmgd(dmg,pos):
	hp -= dmg
	if hp > 0:
		$AnimatedSprite2D.modulate.r = 10
		await get_tree().create_timer(0.1).timeout
		$AnimatedSprite2D.modulate.r = 1
	$ProgressBar.value = hp
	velocity.y -= 100
	velocity.x += 100 if pos.x < position.x else -100
	if hp <= 0:
		velocity.y -= 500
		velocity.x += 500 if pos.x < position.x else -500
		$AnimatedSprite2D.modulate.r = 5
		$CPUParticles2D.emitting = true
		$".".modulate.a = 0.66
		await get_tree().create_timer(0.1).timeout
		$".".modulate.a = 0.33
		await get_tree().create_timer(0.1).timeout
		$".".modulate.a = 0
		queue_free()


func _ready() -> void:
	$AnimatedSprite2D.play("default")


func _physics_process(delta: float) -> void:
	if abs(velocity.x) < 200:
		velocity.x += 500*side*delta
	if not is_on_floor():
		velocity.y += 9.8 * delta * 300
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.collision_layer != 1:
		side *= -1
	if body.collision_layer == 1:
		body.dmgd(damage,position)
