extends Control

const INVENTORY_SCENE := preload("res://scene/inventory.tscn")

var inventory_button: Button
var inventory_window: Node


func _ready() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	_create_inventory_button()


func _unhandled_input(event: InputEvent) -> void:
	if inventory_window != null and is_instance_valid(inventory_window) and event.is_action_pressed("ui_cancel"):
		_close_inventory()


func _create_inventory_button() -> void:
	inventory_button = Button.new()
	inventory_button.name = "InventoryButton"
	inventory_button.tooltip_text = "背包"
	inventory_button.custom_minimum_size = Vector2(72, 72)
	inventory_button.set_anchors_preset(Control.PRESET_TOP_RIGHT)
	inventory_button.offset_left = -96
	inventory_button.offset_top = 24
	inventory_button.offset_right = -24
	inventory_button.offset_bottom = 96
	inventory_button.icon = _make_inventory_icon()
	inventory_button.expand_icon = true
	inventory_button.flat = false
	inventory_button.focus_mode = Control.FOCUS_NONE
	inventory_button.add_theme_stylebox_override("normal", _make_style(Color(0.12, 0.19, 0.17, 0.92), Color(0.74, 0.56, 0.25, 1.0), 4, 12))
	inventory_button.add_theme_stylebox_override("hover", _make_style(Color(0.18, 0.28, 0.24, 0.96), Color(0.9, 0.7, 0.32, 1.0), 4, 12))
	inventory_button.add_theme_stylebox_override("pressed", _make_style(Color(0.08, 0.13, 0.12, 0.98), Color(0.6, 0.44, 0.18, 1.0), 4, 12))
	inventory_button.pressed.connect(_toggle_inventory)
	add_child(inventory_button)


func _toggle_inventory() -> void:
	if inventory_window != null and is_instance_valid(inventory_window):
		_close_inventory()
		return

	inventory_window = INVENTORY_SCENE.instantiate()
	add_child(inventory_window)


func _close_inventory() -> void:
	if inventory_window == null or not is_instance_valid(inventory_window):
		inventory_window = null
		return

	inventory_window.queue_free()
	inventory_window = null


func _make_style(bg_color: Color, border_color: Color, border_width: int, corner_radius: int) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = bg_color
	style.border_color = border_color
	style.border_width_left = border_width
	style.border_width_top = border_width
	style.border_width_right = border_width
	style.border_width_bottom = border_width
	style.corner_radius_top_left = corner_radius
	style.corner_radius_top_right = corner_radius
	style.corner_radius_bottom_right = corner_radius
	style.corner_radius_bottom_left = corner_radius
	return style


func _make_inventory_icon() -> Texture2D:
	var image := Image.create(64, 64, false, Image.FORMAT_RGBA8)
	image.fill(Color(0, 0, 0, 0))

	var outline := Color(0.08, 0.07, 0.05, 1.0)
	var leather := Color(0.68, 0.44, 0.18, 1.0)
	var leather_dark := Color(0.43, 0.27, 0.12, 1.0)
	var clasp := Color(0.93, 0.76, 0.32, 1.0)

	_fill_rect(image, Rect2i(18, 22, 28, 30), outline)
	_fill_rect(image, Rect2i(20, 24, 24, 26), leather)
	_fill_rect(image, Rect2i(20, 40, 24, 10), leather_dark)
	_fill_rect(image, Rect2i(28, 37, 8, 8), clasp)
	_fill_rect(image, Rect2i(30, 39, 4, 4), Color(0.35, 0.23, 0.1, 1.0))

	_draw_line(image, Vector2i(23, 24), Vector2i(23, 17), outline)
	_draw_line(image, Vector2i(24, 17), Vector2i(31, 13), outline)
	_draw_line(image, Vector2i(32, 13), Vector2i(40, 17), outline)
	_draw_line(image, Vector2i(41, 17), Vector2i(41, 24), outline)
	_draw_line(image, Vector2i(25, 24), Vector2i(25, 18), leather_dark)
	_draw_line(image, Vector2i(26, 18), Vector2i(32, 16), leather_dark)
	_draw_line(image, Vector2i(33, 16), Vector2i(39, 18), leather_dark)
	_draw_line(image, Vector2i(39, 18), Vector2i(39, 24), leather_dark)

	return ImageTexture.create_from_image(image)


func _fill_rect(image: Image, rect: Rect2i, color: Color) -> void:
	for x in range(rect.position.x, rect.position.x + rect.size.x):
		for y in range(rect.position.y, rect.position.y + rect.size.y):
			image.set_pixel(x, y, color)


func _draw_line(image: Image, start: Vector2i, end: Vector2i, color: Color) -> void:
	var delta := end - start
	var steps = max(abs(delta.x), abs(delta.y))
	if steps == 0:
		image.set_pixel(start.x, start.y, color)
		return

	for i in range(steps + 1):
		var t := float(i) / float(steps)
		var x := roundi(lerp(float(start.x), float(end.x), t))
		var y := roundi(lerp(float(start.y), float(end.y), t))
		image.set_pixel(x, y, color)
