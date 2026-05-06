extends Area2D


func _ready():
	$Label.visible=false
	
func _on_body_entered(body):
	if body.name == "player":
		$Label.text="從前從前有一段故事......"
		$Label.visible=true
		
func _on_body_exited(body):
	if body.name == "player":
		$Label.visible=false
