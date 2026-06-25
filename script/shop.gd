extends Sprite2D

@onready var player: CharacterBody2D = $"../../player"
@onready var coins_label: Label = $coins_label
@onready var button: Button = $exit_button
@onready var audio_buy: AudioStreamPlayer = $AudioBuy
@onready var audio_in_out: AudioStreamPlayer = $AudioInOut

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_coins_ui(game_manager.coins)
	game_manager.coins_changed.connect(update_coins_ui)
	
func update_coins_ui(amount: int) -> void:
	coins_label.text = str(amount)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	


#莓果的按鈕
func _on_goods_button_1_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property($goods_button1, "scale", Vector2(1.1, 1.1), 0.15).set_trans(Tween.TRANS_SINE)
func _on_goods_button_1_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property($goods_button1, "scale", Vector2(1.0, 1.0), 0.15).set_trans(Tween.TRANS_SINE)
func _on_goods_button_1_pressed() -> void:
	audio_buy.play()
	attempt_to_buy(20,"berrys")
	
#樹皮的按鈕
func _on_goods_button_2_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property($goods_button2, "scale", Vector2(1.1, 1.1), 0.15).set_trans(Tween.TRANS_SINE)
func _on_goods_button_2_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property($goods_button2, "scale", Vector2(1.0, 1.0), 0.15).set_trans(Tween.TRANS_SINE)
func _on_goods_button_2_pressed() -> void:
	audio_buy.play()
	attempt_to_buy(20,"tree")
	
#水的按鈕
func _on_goods_button_3_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property($goods_button3, "scale", Vector2(1.1, 1.1), 0.15).set_trans(Tween.TRANS_SINE)
func _on_goods_button_3_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property($goods_button3, "scale", Vector2(1.0, 1.0), 0.15).set_trans(Tween.TRANS_SINE)
func _on_goods_button_3_pressed() -> void:
	audio_buy.play()
	attempt_to_buy(20,"water")
	
#藥水的按鈕
func _on_goods_button_4_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property($goods_button4, "scale", Vector2(1.1, 1.1), 0.15).set_trans(Tween.TRANS_SINE)
func _on_goods_button_4_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property($goods_button4, "scale", Vector2(1.0, 1.0), 0.15).set_trans(Tween.TRANS_SINE)
func _on_goods_button_4_pressed() -> void:
	audio_buy.play()
	attempt_to_buy(20,"potion")
	
#蚊子的按鈕
func _on_goods_button_5_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property($goods_button5, "scale", Vector2(1.1, 1.1), 0.15).set_trans(Tween.TRANS_SINE)
func _on_goods_button_5_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property($goods_button5, "scale", Vector2(1.0, 1.0), 0.15).set_trans(Tween.TRANS_SINE)
func _on_goods_button_5_pressed() -> void:
	audio_buy.play()
	attempt_to_buy(20,"fly")
	
#蝴蝶的按鈕
func _on_goods_button_6_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property($goods_button6, "scale", Vector2(1.1, 1.1), 0.15).set_trans(Tween.TRANS_SINE)
func _on_goods_button_6_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property($goods_button6, "scale", Vector2(1.0, 1.0), 0.15).set_trans(Tween.TRANS_SINE)
func _on_goods_button_6_pressed() -> void:
	audio_buy.play()
	attempt_to_buy(20,"butterfly")
	
#退出商店的按鈕
func _on_exit_button_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property(button, "scale", Vector2(1.1, 1.1), 0.15).set_trans(Tween.TRANS_SINE)
func _on_exit_button_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property(button, "scale", Vector2(1.0, 1.0), 0.15).set_trans(Tween.TRANS_SINE)
func _on_exit_button_pressed() -> void:
	audio_in_out.play()
	visible = false
	player.can_move=true
	await audio_in_out.finished
	queue_free()
	
#嘗試購買商品(確認錢夠不夠)
func attempt_to_buy(price: int,item:String) ->void:
	if game_manager.coins >= price:
		game_manager.coins -= price
		game_manager.add_item(item)
		print("成功購買了: " + item)
		game_manager.save_game()
	else:
		print("金幣不夠")
