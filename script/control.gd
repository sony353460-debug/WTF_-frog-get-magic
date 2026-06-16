extends Control

@onready var my_image: TextureRect = $TextureRect
@onready var description_label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	description_label.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mouse_entered() -> void:
	description_label.visible = true
	var tween = create_tween()
	tween.tween_property(my_image, "scale", Vector2(1.1, 1.1), 0.15).set_trans(Tween.TRANS_SINE)


func _on_mouse_exited() -> void:
	description_label.visible = false
	var tween = create_tween()
	tween.tween_property(my_image, "scale", Vector2(1.0, 1.0), 0.15).set_trans(Tween.TRANS_SINE)
