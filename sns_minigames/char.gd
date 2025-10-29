extends CharacterBody2D

@export var ml_dmg = 10
@export var hp = 100
@export var ult_regen = 30
@export var rg_dmg = 10

@onready var a = $AnimationPlayer
@onready var pgult = $"../camtar/Camera2D/ult"
@onready var pghp = $"../camtar/Camera2D/hp"
@onready var arws = $"../camtar/Camera2D/arws"

var side = 'r'
var unbreakable = ["atack","range","ult","damage"]
var ar = preload("res://arrow.tscn")
var ins
var atck_fl = false
var coyt_cntr = 0
var jmp_bfr = 0

func _ready() -> void:
	ml_dmg = $"..".stats['ml']
	rg_dmg = $"..".stats['rn']
	ult_regen = $"..".stats['ult']
	hp = $"..".stats['hp']
	pghp.max_value = hp
	pghp.value = hp
	arws.visible = $"..".stats['is_ar']


func dmgd(dmg,pos):
	hp -= dmg
	pghp.value = hp
	if a.current_animation != 'damage':
		if velocity.y > -700:
			velocity.y -= 700
		velocity.x += 1000 if pos.x < position.x else -1000
	if hp > 0:
		a.play("damage")
	if hp <= 0 and $".".modulate.a == 1:
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


func rang(pr_b):
	if not a.current_animation == "range":
		ins = ar.instantiate()
		ins.dmg = rg_dmg
		ins.scale *= 1 if side == 'r' else -1
		ins.velocity = Vector2(1500,-150) if side == 'r' else Vector2(-1500,-150)
		ins.position = $pics/Arm.global_position
		$"..".add_child(ins)
		pr_b.value = 0
	a.play("range")


func _physics_process(delta):
	if hp <= 0:
		return
	elif position.y > 4000:
		dmgd(5,position)
	velocity.x *= 0.9
	
	if arws.visible and a.current_animation != 'range':
		if arws.get_children()[0].value < 100:
			arws.get_children()[0].value += 1
		elif arws.get_children()[1].value < 100:
			arws.get_children()[1].value += 1
		elif arws.get_children()[2].value < 100:
			arws.get_children()[2].value += 1
	
	if not is_on_floor():
		if jmp_bfr > -1:
			jmp_bfr -= 1
		coyt_cntr += 1
		if coyt_cntr > 7:
			velocity.y += 9.8 * delta * 300
	if is_on_floor():
		coyt_cntr = 0
		if jmp_bfr >= 0:
			coyt_cntr = 11 #chtob grav rabotala srazu
			velocity.y += -1400
			a.play("fall")
	
	if Input.is_action_pressed("up") and coyt_cntr < 7:
		coyt_cntr = 11 #chtob grav rabotala srazu
		velocity.y += -1400
		a.play("fall")
		if not is_on_floor():
			jmp_bfr = 5
	elif Input.is_action_pressed("up"):
		jmp_bfr = 5
	
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
			atck_fl = true
			a.play("atack")
	elif Input.is_action_pressed("range") and arws.visible:
		if arws.get_children()[2].value == 100:
			rang(arws.get_children()[2])
		elif arws.get_children()[1].value == 100:
			rang(arws.get_children()[1])
		elif arws.get_children()[0].value == 100:
			rang(arws.get_children()[0])
	elif Input.is_action_pressed("ult") and pgult.value == 100:
		a.play('ult')
		pgult.value = 0
		for i in range(ult_regen):
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
	
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and atck_fl:
		body.dmgd(ml_dmg,position)
		pgult.value += 10


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	atck_fl = false
