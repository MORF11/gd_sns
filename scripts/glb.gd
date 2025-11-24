extends Node

var curr_sc = 'ui'
var is_ad = false

@export var level = 0

@export var max_ml = 0
@export var max_rn = 0
@export var max_hp = 0
@export var max_ult = 0
@export var is_arr = false

func _ready() -> void:
	if !WebBus.is_init:
		await WebBus.inited
	WebBus.ready()
	#while !WebBus.is_init:
		#if WebBus.is_init:
			#await get_tree().create_timer(0.5).timeout
			#WebBus.ready()
	# if error use: if await WebBus.get_stats() is not int ((or is null)): WebBus.set_stats({qwe:0}); sdelal?
	if await WebBus.get_stats('sh') == {}:
		max_hp = 0
	else:
		max_hp = (await WebBus.get_stats('sh'))['sh']
	if await WebBus.get_stats('rn') == {}:
		max_rn = 0
	else:
		max_rn = (await WebBus.get_stats('rn'))['rn']
	if await WebBus.get_stats('mg') == {}:
		max_ult = 0
	else:
		max_ult = (await WebBus.get_stats('mg'))['mg']
	if await WebBus.get_stats('ml') == {}:
		max_ml = 0
	else:
		max_ml = (await WebBus.get_stats('ml'))['ml']
	if await WebBus.get_stats('lv') == {}:
		level = 0
	else:
		level = (await WebBus.get_stats('lv'))['lv']
	
	WebBus.ad_closed.connect(ad_closed)
	WebBus.ad_error.connect(ad_error)
	WebBus.ad_started.connect(ad_started)
	WebBus.reward_added.connect(reward_added)
	#WebBus.show_banner()
	#await get_tree().create_timer(5).timeout
	#WebBus.close_banner()
	WebBus.show_ad()
	#WebBus.start_gameplay()


func ad_started():
	AudioServer.set_bus_mute(0, true)
	#WebBus.stop_gameplay()


func ad_closed():
	AudioServer.set_bus_mute(0, false)
	#WebBus.start_gameplay()


func ad_error():
	#push_warning("oshibka s reklamoi")
	#WebBus.start_gameplay()
	pass


func reward_added():
	#$Player.add_gold(10)
	#WebBus.start_gameplay()
	pass


func _notification(what: int) -> void:
	if not is_ad:
		if what == NOTIFICATION_WM_WINDOW_FOCUS_OUT:
			AudioServer.set_bus_mute(0,true)
		if what == NOTIFICATION_WM_WINDOW_FOCUS_IN:
			AudioServer.set_bus_mute(0,false)


func qw():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	curr_sc = 'ui'


func ch_sc(q:String):
	get_tree().change_scene_to_file(q)
	match q:
		"res://scenes/main.tscn":
			curr_sc = 'ui'
		"res://scenes/howto.tscn":
			curr_sc = 'ht'
		"res://scenes/pltfrmr.tscn":
			curr_sc = 'play'
		"res://scenes/shield.tscn":
			curr_sc = 'sh'
		"res://scenes/sword.tscn":
			curr_sc = 'sw'
		"res://scenes/magic.tscn":
			curr_sc = 'mg'
		"res://scenes/bow.tscn":
			curr_sc = 'rn'
	if q == "res://scenes/congrats.tscn":
		await get_tree().create_timer(5).timeout
		qw()
		if await WebBus.can_rewiew():
			await WebBus.request_review()
		else:
			await WebBus.open_auth_dialog()
			await WebBus.request_review()


func save_dt(key:String,dt:int):
	#match curr_sc:
		#'rn':
			#max_rn = dt
		#'mg':
			#max_ult = dt
		#'sw':
			#max_ml = dt
		#'sh':
			#max_hp = dt
	WebBus.set_data({key:dt})
