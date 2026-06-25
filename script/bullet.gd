extends Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D
const SPEED=500
var direction=1
const DAMAGE=30
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D


func _physics_process(delta):
	if direction==-1:
		sprite_2d.flip_h=true
		
	position.x=position.x+SPEED*direction*delta


func _on_body_entered(body):
	audio_stream_player_2d.play()
	sprite_2d.visible = false
	var enemy=body as EnemyController
	if enemy:
		enemy.ApplyDamage(DAMAGE)
	var fly_enemy=body as FlyingEnemyController
	if fly_enemy:
		fly_enemy.ApplyDamage(DAMAGE)
	await audio_stream_player_2d.finished
	queue_free()
	
