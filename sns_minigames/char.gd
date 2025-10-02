extends CharacterBody2D

@export var ml_dmg = 0
@export var hp = 0
@export var ult_regen = 0
@export var rg_dmg = 0
@onready var a = $AnimationPlayer
var side = 'r'
var unbreakable = ["atack","range","ult"]
var ar = preload("res://arrow.tscn")
var ins

func _ready() -> void:
	a.play("idle")


func _physics_process(delta):
	if a.current_animation == "range":
			a.speed_scale = 0.5
	else:
		a.speed_scale = 1
		
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
		if side != 'r':
			scale.x = -0.6
			side = 'r'
	elif Input.is_action_pressed("left") and abs(velocity.x) < 700:
		velocity.x -= 200
		if is_on_floor():
			if a.current_animation not in unbreakable:
				a.play("walk")
		if side != 'l':
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
			ins.position = $Arm.global_position
			$"..".add_child(ins)
		a.play("range")
	elif Input.is_action_pressed("ult"):
		print(3)
	
	if not Input.is_anything_pressed() and is_on_floor():
		if a.current_animation not in unbreakable:
			a.play("idle")
	if not is_on_floor():
			if a.current_animation not in unbreakable:
				a.play("fall")
	
	velocity.x *= 0.9
	move_and_slide()
