extends Area2D

var is_player_in_range = false
var button = Button.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.text = "購買商品"
	add_child(button)
	button.hide()
	

func _on_body_entered(body):
	if body.name == "player":
		is_player_in_range = true
		button.show()
		button.pressed.connect(_button_pressed)
		

func _on_body_exited(body):
	if body.name == "player":
		is_player_in_range = false
		button.hide()
	
func _button_pressed(delta):
	if is_player_in_range and Input.is_action_just_pressed("ui_interact"):
		print("123")
