extends CharacterBody2D

@export var ml_dmg = 0
@export var hp = 0
@export var ult_dmg = 0
@export var rg_dmg = 0
var j_fl = false
var side = 'r'

func _ready() -> void:
	$AnimationPlayer.play("idle")


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
		$AnimationPlayer.play("walk")
		if side != 'r':
			scale.x = -0.6
			side = 'r'
	elif Input.is_action_pressed("left") and abs(velocity.x) < 500:
		velocity.x -= 100
		$AnimationPlayer.play("walk")
		if side != 'l':
			scale.x = -0.6
			side = 'l'
	
	if Input.is_action_pressed("atack"):
		print(1)
	elif Input.is_action_pressed("range"):
		print(2)
	elif Input.is_action_pressed("ult"):
		print(3)
	
	if not Input.is_anything_pressed():
		$AnimationPlayer.play("idle")
	
	velocity *= 0.92
	move_and_slide()
