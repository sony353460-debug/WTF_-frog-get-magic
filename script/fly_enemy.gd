extends CharacterBody2D
class_name FlyingEnemyController

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_2d_forward: RayCast2D = $CollisionShape2D/RayCast2D_Forward
@onready var area_2d_container: Node2D = $Area2D_Container
@onready var ray_cast_2d_dawnward: RayCast2D = $CollisionShape2D/RayCast2D_Dawnward

var currentHealth: int = 70
var isDead: bool = false
var isAttacking: bool = false

const SPEED: float = 120.0
var direction: int = -1
var initial_y: float

func _ready():
	initial_y = global_position.y

func _process(_delta: float) -> void:
	update_animation()

func _physics_process(_delta: float) -> void:
	if isDead:
		return
		
	if isAttacking:
		if not animated_sprite_2d.is_playing():
			isAttacking = false
			

			

	
	if ray_cast_2d_forward.is_colliding() or ray_cast_2d_dawnward.is_colliding() == false:
		direction = -direction
		ray_cast_2d_forward.target_position.x = -ray_cast_2d_forward.target_position.x
		ray_cast_2d_dawnward.position.x = -ray_cast_2d_dawnward.position.x
		area_2d_container.scale.x = -direction
		
	velocity.x = direction * SPEED
	velocity.y = 0  # 鎖定 Y 速度
	
	move_and_slide()
	
	# move_and_slide 之後再鎖定 Y 位置（防止被碰撞推移）
	global_position.y = initial_y

func update_animation() -> void:
	if isDead:
		return
	if velocity.x != 0:
		animated_sprite_2d.flip_h = velocity.x > 0
	
	if not isAttacking:
		animated_sprite_2d.play("Walk")
	elif animated_sprite_2d.animation != "Attack":
		animated_sprite_2d.play("Attack")

func ApplyDamage(damage: int) -> void:
	if isDead:
		return
		
	currentHealth -= damage
	if currentHealth <= 0:
		isDead = true
		animated_sprite_2d.play("Die")
		set_collision_layer_value(3, false)
		await get_tree().create_timer(2).timeout
		queue_free()

func _on_area_2d_player_detector_body_shape_entered(_body_rid: RID, _body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	isAttacking = true

	
