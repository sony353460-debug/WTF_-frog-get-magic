extends Area2D
@onready var audio_village_head: AudioStreamPlayer2D = $AudioVillageHead


func _ready():
	$Label.visible=false
	
func _on_body_entered(body):
	if body.name == "player":
		$Label.text="從前從前有一段故事......"
		$Label.visible=true
		audio_village_head.play()
func _on_body_exited(body):
	if body.name == "player":
		$Label.visible=false
		audio_village_head.stop()
