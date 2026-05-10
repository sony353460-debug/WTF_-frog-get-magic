extends Area2D

var is_player_in_range = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Button.hide()

func _on_body_entered(body):
	if body.name == "player":
		is_player_in_range = true
		$Button.show()
		
func _on_body_exited(body):
	if body.name == "player":
		is_player_in_range = false
		$Button.hide()

func _on_button_pressed():
	var shop_instance = preload("res://scene/shop.tscn").instantiate()
	$"../CanvasLayer".add_child(shop_instance)
	
	
