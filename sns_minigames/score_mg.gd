extends Label

func _process(_delta: float) -> void:
	$".".text = str($"../CharacterBody2D".score)
