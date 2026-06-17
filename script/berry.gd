extends Area2D

var is_player_in_range = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.visible=false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	pass

func _on_body_entered(body):
	if body is CharacterBody2D:
		is_player_in_range=true
		$Label.text="按F拾取"
		$Label.visible=true
		
		
func _on_body_exited(body):
	if body is CharacterBody2D:
		is_player_in_range=false
		$Label.visible=false
		
func _input(event):
	if is_player_in_range and event.is_action_pressed("interact"):
		pick_up()
		
func pick_up(): 
	game_manager.add_item("berrys")
	queue_free()
