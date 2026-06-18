extends Control

@onready var button:Button = $Panel/exit_button


func _ready() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)

func _on_exit_button_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property(button, "scale", Vector2(1.1, 1.1), 0.15).set_trans(Tween.TRANS_SINE)
	
func _on_exit_button_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property(button, "scale", Vector2(1.0, 1.0), 0.15).set_trans(Tween.TRANS_SINE)
	
	
func _on_exit_button_pressed() -> void:
	queue_free()
