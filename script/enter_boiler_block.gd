extends Area2D

var is_player_in_range = false
@onready var player: CharacterBody2D = $"../player"
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

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
	var boiler_instance = preload("res://scene/boiler.tscn").instantiate()
	audio_stream_player.play()
	$"../CanvasLayer".add_child(boiler_instance)
	
	
