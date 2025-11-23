extends Node2D

var page = 0
var txts = [
	'Цель игры - улучшить навки главного героя
через миниигры и пройти сквозь враждебный мир
навстречу своей мечте - стать полноценным персонажем компьютерной игры.',
	'Этот мир наполнен опасными тварями,
не дайте им себя покалечить используя вашу силу...',
	'Прокачивайте владение мечем
нажав на "ближняя атака" используя WASD',
	'Тренируйте свою прочность во вкладке "здоровье"
управляя щитом мышкой',
	'отрабатывайте силу своего лечения
в миниигре "магия" с помщью мышки',
	'И наконец обретите владение луком
нажав на "дальняя атака" прицеливаясь мышью'
]
var pics = [
	preload("res://assets/scr6_ru.png"),
	preload("res://assets/scr1_ru.png"),
	preload("res://assets/scr5_ru.png"),
	preload("res://assets/scr4_ru.png"),
	preload("res://assets/scr3_ru.png"),
	preload("res://assets/scr2_ru.png")
]

func upd_page(pg):
	$pics/Scr1.texture = pics[pg]
	$Label.text = txts[pg]


func _on_quit_button_down() -> void:
	glb.qw()


func _on_button_button_down() -> void:
	if page != 0:
		page -= 1
		upd_page(page)


func _on_button_2_button_down() -> void:
	if page != 5: #? kakaia max page budet hz
		page += 1
		upd_page(page)
