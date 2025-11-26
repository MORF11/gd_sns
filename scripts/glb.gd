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
	YandexSDK.game_ready()
	YandexSDK.connect("stats_loaded",ld)
	YandexSDK.connect("rewarded_ad",rewd)
	YandexSDK.connect("interstitial_ad",inter)


func ld(_k):
	pass


func rewd(res):
	if res == 'opened':
		AudioServer.set_bus_mute(0,true)
		is_ad = true
	elif res in ['closed','error']:
		AudioServer.set_bus_mute(0,false)
		is_ad = false
	elif res == 'rewarded':
		is_ad = false


func inter(res):
	if res == 'opened':
		AudioServer.set_bus_mute(0,true)
		is_ad = true
	elif res in ['closed','error']:
		AudioServer.set_bus_mute(0,false)
		is_ad = false


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
	#if q == "res://scenes/congrats.tscn":
		#await get_tree().create_timer(5).timeout
		#qw()
		#if await WebBus.can_rewiew():
			#await WebBus.request_review()
		#else:
			#await WebBus.open_auth_dialog()
			#await WebBus.request_review()


func save_dt(_key:String,_dt:int):
	pass
