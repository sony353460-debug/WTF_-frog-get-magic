extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


const START_FRAME=7
const END_FRAME=9
const DAMAGE=30

func _process(delta):
	if animated_sprite_2d.animation=="Attack":
		if animated_sprite_2d.frame>=START_FRAME&&animated_sprite_2d.frame<=END_FRAME:
			monitoring=true
			collision_shape_2d.visible=true
			return
	monitoring=false
	collision_shape_2d.visible=false
func _on_body_entered(body):
	var player=body as PlayertControllor
	if player:
		player.ApplyDamage(DAMAGE)
