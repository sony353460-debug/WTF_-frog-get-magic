extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _on_start_button_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property($start_button, "scale", Vector2(1.1, 1.1), 0.15).set_trans(Tween.TRANS_SINE)
func _on_start_button_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property($start_button, "scale", Vector2(1.0, 1.0), 0.15).set_trans(Tween.TRANS_SINE)
func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scene/animation.tscn")


func _on_set_button_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property($start_button, "scale", Vector2(1.1, 1.1), 0.15).set_trans(Tween.TRANS_SINE)
func _on_set_button_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property($start_button, "scale", Vector2(1.0, 1.0), 0.15).set_trans(Tween.TRANS_SINE)
func _on_set_button_pressed() -> void:
	pass # Replace with function body.
