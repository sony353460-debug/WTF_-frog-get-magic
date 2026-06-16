extends Sprite2D

@onready var player: CharacterBody2D = $"../../player"
@onready var coins_label: Label = $coins_label
@onready var button: Button = $exit_button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_coins_ui(game_manager.coins)
	game_manager.coins_changed.connect(update_coins_ui)
	
func update_coins_ui(amount: int) -> void:
	coins_label.text = str(amount)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_exit_button_pressed() -> void:
	player.can_move=true
	queue_free()

#莓果的按鈕
func _on_goods_button_1_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property($goods_button1, "scale", Vector2(1.1, 1.1), 0.15).set_trans(Tween.TRANS_SINE)
func _on_goods_button_1_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property($goods_button1, "scale", Vector2(1.0, 1.0), 0.15).set_trans(Tween.TRANS_SINE)
func _on_goods_button_1_pressed() -> void:
	attempt_to_buy(20,"莓果")
	
#樹皮的按鈕
func _on_goods_button_2_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property($goods_button2, "scale", Vector2(1.1, 1.1), 0.15).set_trans(Tween.TRANS_SINE)
func _on_goods_button_2_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property($goods_button2, "scale", Vector2(1.0, 1.0), 0.15).set_trans(Tween.TRANS_SINE)
func _on_goods_button_2_pressed() -> void:
	attempt_to_buy(20,"樹皮")
	
#水的按鈕
func _on_goods_button_3_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property($goods_button3, "scale", Vector2(1.1, 1.1), 0.15).set_trans(Tween.TRANS_SINE)
func _on_goods_button_3_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property($goods_button3, "scale", Vector2(1.0, 1.0), 0.15).set_trans(Tween.TRANS_SINE)
func _on_goods_button_3_pressed() -> void:
	attempt_to_buy(20,"水")
	
#藥水的按鈕
func _on_goods_button_4_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property($goods_button4, "scale", Vector2(1.1, 1.1), 0.15).set_trans(Tween.TRANS_SINE)
func _on_goods_button_4_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property($goods_button4, "scale", Vector2(1.0, 1.0), 0.15).set_trans(Tween.TRANS_SINE)
func _on_goods_button_4_pressed() -> void:
	attempt_to_buy(20,"藥水")
	
#蚊子的按鈕
func _on_goods_button_5_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property($goods_button5, "scale", Vector2(1.1, 1.1), 0.15).set_trans(Tween.TRANS_SINE)
func _on_goods_button_5_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property($goods_button5, "scale", Vector2(1.0, 1.0), 0.15).set_trans(Tween.TRANS_SINE)
func _on_goods_button_5_pressed() -> void:
	attempt_to_buy(20,"蚊子")
	
#蝴蝶的按鈕
func _on_goods_button_6_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property($goods_button6, "scale", Vector2(1.1, 1.1), 0.15).set_trans(Tween.TRANS_SINE)
func _on_goods_button_6_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property($goods_button6, "scale", Vector2(1.0, 1.0), 0.15).set_trans(Tween.TRANS_SINE)
func _on_goods_button_6_pressed() -> void:
	attempt_to_buy(20,"蝴蝶")
	
#退出商店的按鈕
func _on_exit_button_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property(button, "scale", Vector2(1.1, 1.1), 0.15).set_trans(Tween.TRANS_SINE)
func _on_exit_button_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property(button, "scale", Vector2(1.0, 1.0), 0.15).set_trans(Tween.TRANS_SINE)
	
	
#嘗試購買商品(確認錢夠不夠)
func attempt_to_buy(price: int,item:String) ->void:
	if game_manager.coins >= price:
		game_manager.coins -= price	
		print("成功購買了: " + item)
		game_manager.save_game()
	else:
		print("金幣不夠")
