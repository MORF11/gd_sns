extends Node2D

@export var time = 2.5

func del(t):
	$Target.modulate.a = 0.75
	await get_tree().create_timer(t).timeout
	$Target.modulate.a = 0.5
	await get_tree().create_timer(t).timeout
	$Target.modulate.a = 0.25
	await get_tree().create_timer(t).timeout
	$Target.modulate.a = 0
	queue_free()


func _ready() -> void:
	$Timer.start(time)
	for i in range(5):
		await get_tree().create_timer(time/10.5).timeout
		$Target.modulate.b -= 0.2
		$Target.modulate.g -= 0.2
	await get_tree().create_timer(time/25).timeout
	$Target.modulate.b = 9
	$Target.modulate.g = 9
	$Target.modulate.r = 9


func _on_timer_timeout() -> void:
	del(0.1)
