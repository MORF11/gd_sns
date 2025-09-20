extends CharacterBody2D

#@onready var me = $"."
#@onready var chrctr = $"../chrctr"
#func _process(delta: float) -> void:
	#velocity = Vector2.ZERO
	#velocity = me.position.direction_to(chrctr.position) * 25000 * delta
	#move_and_slide()

@export var is_spawned = false

func _process(delta: float) -> void:
	if is_spawned:
		velocity = Vector2.ZERO
		velocity = $".".position.direction_to(Vector2.ZERO) * 25000 * delta
		move_and_slide()
	
