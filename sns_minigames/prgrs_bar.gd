extends ProgressBar

@onready var lvl = $"..".get_parent().get_child(5)

func add():
	value += 10
	if value > 100:
		value = 0
		lvl.add()
