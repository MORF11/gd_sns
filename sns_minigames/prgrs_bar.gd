extends ProgressBar

func add():
	value += 10
	if value > 100:
		value = 0
		
