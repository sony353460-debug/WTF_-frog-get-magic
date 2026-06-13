extends Camera2D


func _ready():
	# 用絕對路徑找 TileMapLayer（改成你場景裡的實際路徑）
	var tilemap_layer = get_node("/root/Node2D/TileMapLayer")
	var used_rect = tilemap_layer.get_used_rect()
	var tile_size = tilemap_layer.tile_set.tile_size
	
	# self 就是這個 Camera2D 本身
	limit_left   = used_rect.position.x * tile_size.x
	
	limit_right  = used_rect.end.x * tile_size.x

	
