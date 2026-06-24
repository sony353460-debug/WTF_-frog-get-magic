@tool # 加上 @tool 讓你在編輯器裡拉動捲軸就能即時看到形狀變化！
extends Control

# 設定上方分割點的 X 軸比例 (0.0 左邊 ~ 1.0 右邊)
@export_range(0.0, 1.0) var top_split: float = 0.7:
	set(value):
		top_split = value
		queue_redraw() # 數值改變時重新繪製

# 設定下方分割點的 X 軸比例
@export_range(0.0, 1.0) var bottom_split: float = 0.3:
	set(value):
		bottom_split = value
		queue_redraw()

# 面板的底色
@export var bg_color: Color = Color(0.2, 0.2, 0.2, 1.0):
	set(value):
		bg_color = value
		queue_redraw()

# 決定這個節點是左半邊還是右半邊
@export var is_left_side: bool = true:
	set(value):
		is_left_side = value
		queue_redraw()

func _draw():
	var w = size.x
	var h = size.y
	var points = PackedVector2Array()

	if is_left_side:
		# 左側多邊形：左上 -> 上方分割點 -> 下方分割點 -> 左下
		points.push_back(Vector2(0, 0))
		points.push_back(Vector2(w * top_split, 0))
		points.push_back(Vector2(w * bottom_split, h))
		points.push_back(Vector2(0, h))
	else:
		# 右側多邊形：上方分割點 -> 右上 -> 右下 -> 下方分割點
		points.push_back(Vector2(w * top_split, 0))
		points.push_back(Vector2(w, 0))
		points.push_back(Vector2(w, h))
		points.push_back(Vector2(w * bottom_split, h))

	# 畫出填滿顏色的多邊形
	draw_polygon(points, PackedColorArray([bg_color]))
