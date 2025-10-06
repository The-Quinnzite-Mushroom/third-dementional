extends CharacterBody2D

@onready var weapon_container: WeaponContainer = $weaponContainer
@onready var upper_arm: Sprite2D = $weaponContainer/UpperArm
@onready var lower_arm: Sprite2D = $weaponContainer/LowerArm
@onready var torso_sprite: AnimatedSprite2D = $torsoContainer/torsoSprite
@onready var legs_sprite: AnimatedSprite2D = $legsContainer/legsSprite
@onready var equip: AudioStreamPlayer2D = $Equip
@onready var hurt: AudioStreamPlayer2D = $hurt
@onready var jump: AudioStreamPlayer2D = $jump

var speed = 200.0
var jump_velocity = -300.0
const GRAVITY = 400

var health = 300
var current_legs_index: int = 0
var current_torso_index: int = 0
var current_weapon_index: int = 0
var current_drop = null

func _ready() -> void:
	update_health()
	
func _input(event):
	if event.is_action_pressed("interact"):
	
		print(current_weapon_index)
		if current_weapon_index >= 0:
			weapon_container.swap_weapon(current_weapon_index)
			equip.play()
			current_weapon_index
		elif current_torso_index >= 0:
			swap_torso()
			equip.play()
		elif current_legs_index >= 0:
			swap_legs()
			equip.play()
			
		if current_drop:
			current_drop.queue_free()
			current_drop = null
			
var flip_h = false

func switch_weapon_index(index, drop = null):
	current_weapon_index = index
	if drop:
		current_drop = drop 

func swap_torso():
	if current_torso_index == 1:
		pass
	elif current_torso_index == 2:
		pass
	elif current_torso_index == 3:
		pass

func swap_legs():
	if current_legs_index == 1:
		jump_velocity = -300
		speed = 200
		health = 700
	elif current_legs_index == 2:
		jump_velocity = -300
		speed = 400
		health = 500
	elif current_legs_index == 3:
		jump_velocity = -600
		speed = 200
		health = 500

func _physics_process(delta: float) -> void:
	# Add the gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = jump_velocity
		jump.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	if velocity.x > 0 and flip_h:
		flip_h = false
		torso_sprite.flip_h = false
		legs_sprite.flip_h = false
		
	elif velocity.x < 0 and !flip_h:
		flip_h = true
		torso_sprite.flip_h = true
		legs_sprite.flip_h = true
		
		
	move_and_slide()
	

func change_legs_index(index, drop = null):
	current_legs_index = index
	if drop:
		current_drop = drop 
	
	
func change_torso_index(index, drop = null):
	current_torso_index = index
	if drop:
		current_drop = drop 
	


func take_damage(dmg):
	hurt.play()
	health -= dmg
	update_health()
	if health <= 0:
		get_tree().change_scene_to_file("res://scenes/menus/death_menu.tscn")
		
func update_health():
	$HealthBar.value = health

func _on_area_2d_area_entered(area: Area2D) -> void:
	print("Player area entered by: ",area)
