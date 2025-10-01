extends CharacterBody2D

@export var ml_dmg = 0
@export var hp = 0
@export var ult_dmg = 0
@export var rg_dmg = 0
var j_fl = false

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += 9.8 * delta * 300
		if j_fl and velocity.y > 0:
			velocity.y += 500
			j_fl = false
		
	if Input.is_action_pressed("up") and is_on_floor():
		velocity.y += -1300
		j_fl = true
	
	if Input.is_action_pressed("right") and abs(velocity.x) < 500:
		velocity.x += 30
		if global_scale.x != 0.6:
			global_scale.x = 0.6
	elif Input.is_action_pressed("left") and abs(velocity.x) < 500:
		velocity.x -= 30
		if scale.x != -0.6:
			scale.x = -0.6
			print(global_scale.x," ",global_scale.y," ",scale.x," ",scale.y,"\n")
	
	if Input.is_action_pressed("atack"):
		print(1)
	elif Input.is_action_pressed("range"):
		print(2)
	elif Input.is_action_pressed("ult"):
		print(3)
	
	velocity *= 0.92
	move_and_slide()
