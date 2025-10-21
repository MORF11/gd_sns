extends CharacterBody2D

@export var damage = 10
@export var hp = 100
@export var r_dmg = 10
@export var shoot_fl = false
var is_plr = false
var is_wl = false
var blt = preload("res://bullet.tscn")
var ins
var vlct = Vector2.ZERO
var side = 'r'

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


func _physics_process(delta: float) -> void:
	if shoot_fl and is_plr:
		ins = blt.instantiate()
		ins.nmy_fl = true
		ins.position = $".".global_position + Vector2(50,130)
		ins.velocity = Vector2(2500 if side == 'r' else -2500,1200)
		$"..".add_child(ins)
	
	if is_plr:
		vlct.x += (1 if side == 'r' else -1) * delta * -2000
		if $"../plr".global_position.x > global_position.x:
			scale.x *= 1 if side == 'r' else -1
			side = 'r'
			$ProgressBar.fill_mode = 0
		else:
			scale.x *= 1 if side == 'l' else -1
			side = 'l'
			$ProgressBar.fill_mode = 1
	if is_wl:
		vlct.y += -130
	
	if velocity.y < 300 and is_wl:
		velocity.y += vlct.y * delta * 100
	if velocity.x < 300:
		velocity.x += vlct.x * delta * 100
	velocity.y += 9.8 * delta * 100
	vlct = Vector2.ZERO
	velocity *= 0.9
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.collision_layer != 1:
		is_wl = true
	if body.collision_layer == 1:
		is_plr = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.collision_layer != 1:
		is_wl = false
	if body.collision_layer == 1:
		is_plr = false
