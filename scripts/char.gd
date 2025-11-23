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
var cif = preload("res://scenes/ciforka_dmg.tscn")
var ar = preload("res://scenes/arrow.tscn")
var ins
var atck_fl = false
var coyt_cntr = 0
var jmp_bfr = 0
var stop = false

func _ready() -> void:
	$ult_prt.emitting = false
	ml_dmg = int(10+(glb.max_ml/10.0))
	rg_dmg = int(10+(glb.max_rn/10.0))
	ult_regen = int(20+(glb.max_ult/10.0))
	hp = int(100+(glb.max_hp/10.0))
	pghp.max_value = hp
	pghp.value = hp
	arws.visible = glb.is_arr
	#arws.visible = true


func dmgd(dmg,pos):
	if a.current_animation == 'damage':
		return
	hp -= dmg
	ins = cif.instantiate()
	ins.dmg = dmg
	ins.global_position = global_position
	$"..".add_child(ins)
	pghp.value = hp
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
		glb.is_arr = false
		queue_free()


func _physics_process(delta):
	if hp <= 0 or stop:
		return
	elif position.y > 4000:
		dmgd(25,position)
	velocity.x *= 0.9
	if abs(velocity.x) < 30 and not Input.is_anything_pressed():
		velocity.x = 0
	if arws.visible and arws.get_children()[0].value < 100:
		arws.get_children()[0].value += 1
	
	if not is_on_floor():
		if jmp_bfr > -1:
			jmp_bfr -= 1
		coyt_cntr += 1
		if coyt_cntr > 7:
			velocity.y += 9.8 * delta * 300
	if is_on_floor():
		coyt_cntr = 0
		if jmp_bfr >= 0:
			coyt_cntr = 52 #chtob grav rabotala srazu
			velocity.y += -1400
			a.play("fall")
	
	if Input.is_action_pressed("up") and coyt_cntr < 7:
		coyt_cntr = 52 #chtob grav rabotala srazu
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
	elif Input.is_action_pressed("range") and arws.visible and arws.get_children()[0].value == 100:
		if not a.current_animation == "range":
			ins = ar.instantiate()
			ins.dmg = rg_dmg
			ins.scale *= 1 if side == 'r' else -1
			ins.velocity = (Vector2(1500,-150) if side == 'r' else Vector2(-1500,-150)) + velocity/2.5
			ins.position = $pics/Arm.global_position
			$"..".add_child(ins)
			arws.get_children()[0].value = 0
			a.play("range")
	elif Input.is_action_pressed("ult") and pgult.value == 100:
		a.play('ult')
		pgult.value = 0
		for i in range(ult_regen):
			if hp < 100:
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
		body.dmgd(ml_dmg if randi()%100 not in [42,52,69,67,61,99,0,29,28,14] else ml_dmg*2,position) #tipo crit
		#body.dmgd(ml_dmg if (randi()%100)%10 != 0 else ml_dmg*2,position) #tipo crit
		ins = cif.instantiate()
		ins.dmg = ml_dmg
		ins.global_position = body.global_position
		$"..".add_child(ins)
		pgult.value += 10


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	atck_fl = false
