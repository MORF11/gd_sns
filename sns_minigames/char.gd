extends CharacterBody2D

@export var ml_dmg = 10
@export var hp = 100
@export var ult_regen = 30
@export var rg_dmg = 0

@onready var a = $AnimationPlayer
@onready var pgult = $"../camtar/Camera2D/ult"
@onready var pghp = $"../camtar/Camera2D/hp"

var side = 'r'
var unbreakable = ["atack","range","ult","damage"]
var ar = preload("res://arrow.tscn")
var ins

func dmgd(dmg,pos):
	hp -= dmg
	if hp > 0:
		a.play("damage")
	pghp.value = hp
	velocity.y -= 1000
	velocity.x += 1000 if pos.x < position.x else -1000
	if hp <= 0:
		$CPUParticles2D.emitting = true
		a.play("fall")
		$".".modulate.a = 0.66
		await get_tree().create_timer(0.1).timeout
		$".".modulate.a = 0.33
		await get_tree().create_timer(0.1).timeout
		$".".modulate.a = 0
		await get_tree().create_timer(1).timeout
		$"../camtar"._on_button_button_down()
		queue_free()


func _ready() -> void:
	a.play("idle")


func _physics_process(delta):
	if hp <= 0:
		return
	if not is_on_floor():
		velocity.y += 9.8 * delta * 300
		
	if Input.is_action_pressed("up") and is_on_floor():
		velocity.y += -1400
		a.play("fall")
	
	if Input.is_action_pressed("right") and abs(velocity.x) < 700:
		velocity.x += 200
		if is_on_floor():
			if a.current_animation not in unbreakable:
				a.play("walk")
		if side != 'r' and a.current_animation not in ['atack','range']:
			scale.x = -0.6
			side = 'r'
	elif Input.is_action_pressed("left") and abs(velocity.x) < 700:
		velocity.x -= 200
		if is_on_floor():
			if a.current_animation not in unbreakable:
				a.play("walk")
		if side != 'l' and a.current_animation not in ['atack','range']:
			scale.x = -0.6
			side = 'l'
	
	if Input.is_action_pressed("atack"):
		if a.current_animation not in unbreakable:
			a.play("atack")
	elif Input.is_action_pressed("range"):
		if not a.current_animation == "range":
			ins = ar.instantiate()
			ins.dmg = rg_dmg
			ins.scale *= 1 if side == 'r' else -1
			ins.velocity = Vector2(1500,-150) if side == 'r' else Vector2(-1500,-150)
			ins.position = $pics/Arm.global_position
			$"..".add_child(ins)
		a.play("range")
	elif Input.is_action_pressed("ult") and pgult.value == 100:
		a.play('ult')
		pgult.value = 0
		@warning_ignore("integer_division")
		for i in range(int(ult_regen)):
			if hp + 1 <= 100:
				hp += 1
				pghp.value = hp
				await get_tree().create_timer(0.01).timeout
	
	if not Input.is_anything_pressed() and is_on_floor():
		if a.current_animation not in unbreakable:
			a.play("idle")
	if not is_on_floor():
			if a.current_animation not in unbreakable:
				a.play("fall")
	
	velocity.x *= 0.9
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.dmgd(ml_dmg,position)
		pgult.value += 10
