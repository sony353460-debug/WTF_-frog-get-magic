extends Sprite2D

@onready var slots: Array = $"MarginContainer/VBoxContainer/GridContainer".get_children()
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
#合成一的素材
var synthesis1 = ["water","tree","berrys"]
var synthesis2 = ["water","tree","butterfly"]
var synthesis3 = ["fly","water","berrys"]
var statue = ""
var inventory_items = game_manager.backpack
var db = game_manager.item_database

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

#退出按鈕
func _on_exit_button_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property($exit_button, "scale", Vector2(1.1, 1.1), 0.15).set_trans(Tween.TRANS_SINE)
func _on_exit_button_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property($exit_button, "scale", Vector2(1.0, 1.0), 0.15).set_trans(Tween.TRANS_SINE)
func _on_exit_button_pressed() -> void:
	queue_free()
	
	
#第一頁頁籤
func _on_page_1_mouse_entered() -> void:
	pass # Replace with function body.
func _on_page_1_mouse_exited() -> void:
	pass # Replace with function body.
func _on_page_1_pressed() -> void:
	pass # Replace with function body.

#第二頁頁籤
func _on_page_2_mouse_entered() -> void:
	pass # Replace with function body.
func _on_page_2_mouse_exited() -> void:
	pass # Replace with function body.
func _on_page_2_pressed() -> void:
	pass # Replace with function body.
	
#合成一
func _on_material_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property($material, "scale", Vector2(1.1, 1.1), 0.15).set_trans(Tween.TRANS_SINE)
func _on_material_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property($material, "scale", Vector2(1.0, 1.0), 0.15).set_trans(Tween.TRANS_SINE)
func _on_material_pressed() -> void:
	statue = 1
	for i in range(slots.size()):
		var texture_rect = slots[i].get_node_or_null("TextureRect")
		var current_item_id = synthesis1[i]
		var img_path = db[current_item_id]["icon_path"]
		if inventory_items.has(current_item_id):
			texture_rect.texture = load(img_path)
			texture_rect.show()
		else:
			texture_rect.texture = load(img_path)
			var tween = create_tween()
			tween.tween_property(texture_rect, "modulate:a", 0.3, 0.0)
			texture_rect.show()
	
	
	
#合成二
func _on_material_2_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property($material2, "scale", Vector2(1.1, 1.1), 0.15).set_trans(Tween.TRANS_SINE)
func _on_material_2_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property($material2, "scale", Vector2(1.0, 1.0), 0.15).set_trans(Tween.TRANS_SINE)
func _on_material_2_pressed() -> void:
	statue = 2
	for i in range(slots.size()):
		var texture_rect = slots[i].get_node_or_null("TextureRect")
		var current_item_id = synthesis2[i]
		var img_path = db[current_item_id]["icon_path"]
		if inventory_items.has(current_item_id):
			texture_rect.texture = load(img_path)
			texture_rect.show()
		else:
			texture_rect.texture = load(img_path)
			var tween = create_tween()
			tween.tween_property(texture_rect, "modulate:a", 0.3, 0.0)
			texture_rect.show()
	
	
#合成三
func _on_material_3_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property($material3, "scale", Vector2(1.1, 1.1), 0.15).set_trans(Tween.TRANS_SINE)
func _on_material_3_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property($material3, "scale", Vector2(1.0, 1.0), 0.15).set_trans(Tween.TRANS_SINE)
func _on_material_3_pressed() -> void:
	statue = 3
	for i in range(slots.size()):
		var texture_rect = slots[i].get_node_or_null("TextureRect")
		var current_item_id = synthesis3[i]
		var img_path = db[current_item_id]["icon_path"]
		if inventory_items.has(current_item_id):
			texture_rect.texture = load(img_path)
			texture_rect.show()
		else:
			texture_rect.texture = load(img_path)
			var tween = create_tween()
			tween.tween_property(texture_rect, "modulate:a", 0.3, 0.0)
			texture_rect.show()
	
	
#確認按鈕
func _on_check_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property($check, "scale", Vector2(1.1, 1.1), 0.15).set_trans(Tween.TRANS_SINE)
func _on_check_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property($check, "scale", Vector2(1.0, 1.0), 0.15).set_trans(Tween.TRANS_SINE)
func _on_check_pressed() -> void:
	audio_stream_player.play()
	if statue == 1:
		if inventory_items.has(synthesis1[0]) and inventory_items.has(synthesis1[1]) and inventory_items.has(synthesis1[2]):
			game_manager.add_item("restoration_potion")
			game_manager.delete_item(synthesis1[0])
			game_manager.delete_item(synthesis1[1])
			game_manager.delete_item(synthesis1[2])
			for i in range(slots.size()):
				var texture_rect = slots[i].get_node_or_null("TextureRect")
				var tween = create_tween()
				tween.tween_property(texture_rect, "modulate:a", 0.0, 0.0)
	elif statue == 2:
		if inventory_items.has(synthesis2[0]) and inventory_items.has(synthesis2[1]) and inventory_items.has(synthesis2[2]):
			game_manager.add_item("invincible_potion")
			game_manager.delete_item(synthesis2[0])
			game_manager.delete_item(synthesis2[1])
			game_manager.delete_item(synthesis2[2])
			for i in range(slots.size()):
				var texture_rect = slots[i].get_node_or_null("TextureRect")
				var tween = create_tween()
				tween.tween_property(texture_rect, "modulate:a", 0.0, 0.0)
	elif statue == 3:
		if inventory_items.has(synthesis3[0]) and inventory_items.has(synthesis3[1]) and inventory_items.has(synthesis3[2]):
			game_manager.add_item("food")
			game_manager.delete_item(synthesis3[0])
			game_manager.delete_item(synthesis3[1])
			game_manager.delete_item(synthesis3[2])
			for i in range(slots.size()):
				var texture_rect = slots[i].get_node_or_null("TextureRect")
				var tween = create_tween()
				tween.tween_property(texture_rect, "modulate:a", 0.0, 0.0)
