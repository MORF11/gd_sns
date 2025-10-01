extends CharacterBody2D

#@onready var me = $"."
#@onready var chrctr = $"../chrctr"
#func _process(delta: float) -> void:
	#velocity = Vector2.ZERO
	#velocity = me.position.direction_to(chrctr.position) * 25000 * delta
	#move_and_slide()

@export var is_spawned = false
@export var sp = 25000
var rot = randi()%10+10

func _process(delta: float) -> void:
	if is_spawned:
		$".".rotation += deg_to_rad(rot)
		if rad_to_deg($".".rotation) > 360:
			$".".rotation = 0
		velocity = Vector2.ZERO
		velocity = $".".position.direction_to(Vector2.ZERO) * sp * delta
		move_and_slide()
	
