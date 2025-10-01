extends Label

var lvls = 0

func add():
	lvls += 1
	$".".text = str(lvls)
