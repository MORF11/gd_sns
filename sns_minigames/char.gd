extends CharacterBody2D

@export var ml_dmg = 0
@export var hp = 0
@export var ult_regen = 0
@export var rg_dmg = 0
@onready var a = $AnimationPlayer
var j_fl = false
var side = 'r'
var unbreakable = ["atack","range","ult"]

func _ready() -> void:
	a.play("idle")


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += 9.8 * delta * 300
		if j_fl and velocity.y > 0:
			velocity.y += 500
			j_fl = false
		
	if Input.is_action_pressed("up") and is_on_floor():
		velocity.y += -2000
		j_fl = true
	
	if Input.is_action_pressed("right") and abs(velocity.x) < 500:
		velocity.x += 100
		if is_on_floor():
			if a.current_animation not in unbreakable:
				a.play("walk")
		if side != 'r':
			scale.x = -0.6
			side = 'r'
	elif Input.is_action_pressed("left") and abs(velocity.x) < 500:
		velocity.x -= 100
		if is_on_floor():
			if a.current_animation not in unbreakable:
				a.play("walk")
		if side != 'l':
			scale.x = -0.6
			side = 'l'
	
	if Input.is_action_pressed("atack"):
		a.play("atack")
	elif Input.is_action_pressed("range"):
		a.play("range")
	elif Input.is_action_pressed("ult"):
		print(3)
	
	if not Input.is_anything_pressed() and is_on_floor():
		if a.current_animation not in unbreakable:
			a.play("idle")
	if not is_on_floor():
			if a.current_animation not in unbreakable:
				a.play("fall")
	
	velocity *= 0.92
	move_and_slide()
