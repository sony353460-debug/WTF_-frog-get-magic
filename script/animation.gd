extends Control

@onready var slot_1 = $VBoxContainer/HBoxContainer/slot1
@onready var slot_2 = $VBoxContainer/HBoxContainer/slot2
@onready var slot_3 = $VBoxContainer/HBoxContainer2/slot3
@onready var slot_4 = $VBoxContainer/HBoxContainer2/slot4


var step = 0
var is_transitioning = false

func _ready():
	# 初始化：把所有漫畫格子與文字都設為透明
	slot_1.modulate.a = 0.0
	slot_2.modulate.a = 0.0
	slot_3.modulate.a = 0.0
	slot_4.modulate.a = 0.0

	
	# 進入遊戲自動播放第一組（圖1+圖2）
	play_next_step()

func _input(event):
	# 偵測滑鼠左鍵點擊或空白鍵
	if (event.is_action_pressed("ui_accept") or event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
		if is_transitioning:
			return # 動畫播完前不能連點
		play_next_step()

func play_next_step():
	is_transitioning = true
	
	if step == 0:
		var tween = create_tween()
		tween.tween_property(slot_1, "modulate:a", 1.0, 0.6)
		tween.finished.connect(func(): is_transitioning = false)
		step = 1
		
	elif step == 1:
		var tween = create_tween()
		tween.tween_property(slot_1, "modulate:a", 0.3, 0.5)
		tween.tween_property(slot_2, "modulate:a", 1.0, 0.6)
		tween.finished.connect(func(): is_transitioning = false)
		step = 2
	
	elif step == 2:
		var tween = create_tween()
		tween.tween_property(slot_2, "modulate:a", 0.3, 0.5)
		tween.tween_property(slot_3, "modulate:a", 1.0, 0.6)
		tween.finished.connect(func(): is_transitioning = false)
		step = 3
		
	elif step == 3:
		var tween = create_tween()
		tween.tween_property(slot_3, "modulate:a", 0.3, 0.5)
		tween.tween_property(slot_4, "modulate:a", 1.0, 0.6)
		tween.finished.connect(func(): is_transitioning = false)
		step = 4
		
	elif step == 4:
		get_tree().change_scene_to_file("res://scene/hamlet.tscn")
