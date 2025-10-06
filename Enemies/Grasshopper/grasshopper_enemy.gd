extends Enemy 

@export var GRAVITY: float = 800.0 
@export var JUMP_INTERVAL: float = 1
@export var damage: int = 30
var direction = 1 

@onready var ray_cast_right: RayCast2D = $RayCastRight 
@onready var ray_cast_left: RayCast2D = $RayCastLeft 
@onready var jump_timer: Timer = $JumpTimer 

func _ready() -> void: 
	jump_timer.wait_time = JUMP_INTERVAL 
	jump_timer.start() 
	
func _process(delta: float) -> void: 
	if !is_on_floor(): 
		velocity.y += GRAVITY * delta 
	else: 
		velocity.x = 0 
		velocity.y = 0 
	
	direction = 1 if randf() > 0.5 else -1 
	
	if (ray_cast_right.is_colliding()): 
		direction = -1 
	if (ray_cast_left.is_colliding()): 
		direction = 1 
		
	move_and_slide() 
	
func jump() -> void: 
	if (is_on_floor()):
		velocity.x = direction * randf_range(100.0, 130.0) 
		velocity.y = -randf_range(300.0, 400.0) 
		move_and_slide() 
	
func _on_timer_timeout() -> void: 
	jump()

const HOPPER_LEGS = preload("res://Enemies/Grasshopper/hopper_legs.tres")
const HOPPER_TORSO = preload("res://Enemies/Grasshopper/hopper_torso.tres")
const HOPPER_WEAPON = preload("res://Enemies/Grasshopper/hopper_weapon.tres")

func drop_equipable():
	randomize()
	var drop_percent = randf()
	
	print("drop percent: " + str(drop_percent))
	if drop_percent < .33:
		var enemy_drop = ENEMY_DROP.instantiate()
		

		get_tree().current_scene.add_child(enemy_drop)
		enemy_drop.initialize(HOPPER_WEAPON)
		enemy_drop.global_position = global_position
