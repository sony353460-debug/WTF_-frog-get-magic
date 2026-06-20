extends GridContainer


@onready var slots: Array = get_children()

func _ready() -> void:
	game_manager.inventory_updated.connect(update_slots)
	update_slots()

func update_slots() -> void:
	var inventory_items = game_manager.backpack
	var db = game_manager.item_database
	
	for i in range(slots.size()):
		var texture_rect = slots[i].get_node_or_null("TextureRect")

		if not texture_rect:
			continue
			
		var current_item_id = inventory_items[i]
		# 如果這一格有物品 ID，且資料庫存在該物品
		if current_item_id != "" and db.has(current_item_id):
			var img_path = db[current_item_id]["icon_path"]
			texture_rect.texture = load(img_path) # 動態載入圖片
			texture_rect.show()
		else:
			# 空白格子
			texture_rect.texture = null
			texture_rect.hide()
