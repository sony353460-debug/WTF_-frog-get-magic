extends Control


func _ready() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)


func _on_exit_button_pressed() -> void:
	queue_free()
