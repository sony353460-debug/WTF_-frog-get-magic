extends CharacterBody2D
class_name EnemyController
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_2d_forward: RayCast2D = $CollisionShape2D/RayCast2D_Forward
@onready var ray_cast_2d_dawnward: RayCast2D = $CollisionShape2D/RayCast2D_Dawnward
@onready var area_2d_container: Node2D = $Area2D_Container


var currentHealth=100
var isDead=false
var isAttacking=false

const SPEED=50
var diretion=-1

func _process(delta):
	UpdateAnimation()

func _physics_process(delta):
	if is_on_floor()==false:
		velocity.y=300
		
	if isDead:
		return
		
	if isAttacking:
		if animated_sprite_2d.is_playing()==false:
			isAttacking=false
		else:
			return
	
	if ray_cast_2d_forward.is_colliding() or ray_cast_2d_dawnward.is_colliding()==false:
		diretion=-diretion
		ray_cast_2d_forward.target_position.x=-ray_cast_2d_forward.target_position.x
		ray_cast_2d_dawnward.position.x=-ray_cast_2d_dawnward.position.x
		area_2d_container.scale.x=-diretion
		
	velocity.x=diretion*SPEED
	
	move_and_slide()

func  UpdateAnimation():
	if isDead:
		return
	if velocity.x!=0:
		animated_sprite_2d.flip_h=velocity.x>0
	
	if isAttacking==false:
		animated_sprite_2d.play("Walk")
	elif animated_sprite_2d.animation!="Attack":
		animated_sprite_2d.play("Attack")
	

func ApplyDamage(damage:int):
	if isDead:
		return
		
	currentHealth-=damage
	if currentHealth<=0:
		isDead=true
		animated_sprite_2d.play("Die")
		set_collision_layer_value(3,false)
		game_manager.coins+=20
		await get_tree().create_timer(2).timeout
		queue_free()

func _on_area_2d_player_detector_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int):
	isAttacking=true
