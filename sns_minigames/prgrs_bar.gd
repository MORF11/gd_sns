extends ProgressBar

@onready var lvl = $"..".get_parent().get_child(8)

func add():
	#print($"..".get_parent().get_children())
	value += 10
	if value > 100:
		value = 0
		lvl.add()
