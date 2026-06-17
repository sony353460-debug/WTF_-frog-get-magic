extends Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D
const SPEED=500
var direction=1
const DAMAGE=30


func _physics_process(delta):
	if direction==-1:
		sprite_2d.flip_h=true
		
	position.x=position.x+SPEED*direction*delta


func _on_body_entered(body):
	var enemy=body as EnemyController
	if enemy:
		enemy.ApplyDamage(DAMAGE)
	var fly_enemy=body as FlyingEnemyController
	if fly_enemy:
		fly_enemy.ApplyDamage(DAMAGE)
	queue_free()
	
