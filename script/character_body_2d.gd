extends CharacterBody2D
class_name PlayertControllor
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_move: AudioStreamPlayer2D = $AudioMove
@onready var audio_water_ball: AudioStreamPlayer2D = $AudioWaterBall
@onready var audio_jump: AudioStreamPlayer2D = $AudioJump



const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const MAX_JUMP_VELOCITY=-1500.0
var can_move=true




#每秒執行好幾次updateanimaed()
func _process(delta):
	updateanimaed()

func _physics_process(delta: float) -> void:
	if game_manager.currentHealth<=0:
		return
	if can_move==false:
		animated_sprite_2d.play("Idile")
		return
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = MAX_JUMP_VELOCITY
		audio_jump.play()
	if Input.is_action_just_released("ui_accept") and velocity.y<JUMP_VELOCITY:
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if animated_sprite_2d.animation == "Run":
		if animated_sprite_2d.frame ==4:
			audio_move.play()
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	#射擊
	if Input.is_action_just_pressed("Shoot"):
		TryToShoot()
		audio_water_ball.play()

	move_and_slide()
#動畫帧
func updateanimaed():
	if game_manager.currentHealth<=0:

		return
	if velocity.x!=0:
		animated_sprite_2d.flip_h=velocity.x<0
	
	if is_on_floor():
		if abs(velocity.x)>=0.1:
			animated_sprite_2d.play("Run")
		else:
			animated_sprite_2d.play("Idile")
			
var is_Shooting = false
const SHOOT_DURATION = 0.249
func TryToShoot():
	if is_Shooting:
		return # 如果正在射擊中，則不重複觸發
	is_Shooting = true
	Shoot()          # 呼叫生成子彈 
	
	# 等待冷卻時間結束後，重設射擊狀態
	await get_tree().create_timer(SHOOT_DURATION).timeout
	is_Shooting = false

func Shoot():
	var bulletToSpawn = preload("res://scene/bullet.tscn")
	var vfxInstance = bulletToSpawn.instantiate()
	get_tree().get_root().get_node("Node2D").add_child(vfxInstance)
	# 在發射點的全局座標生成子彈
	vfxInstance.global_position = global_position
	# 根據玩家目前的翻轉狀態（面向）決定子彈飛行方向
	if animated_sprite_2d.flip_h:
		vfxInstance.direction = -1  # 向左
	else:
		vfxInstance.direction = 1   # 向右

func ApplyDamage(damage:int):
	if game_manager.currentHealth<=0:
		return
	game_manager.currentHealth-=damage

	if game_manager.currentHealth<=0:
		game_manager.currentHealth=0
		animated_sprite_2d.play("Die")
