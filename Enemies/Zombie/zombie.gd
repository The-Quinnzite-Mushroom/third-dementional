extends Enemy

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var speed: float = 120
@export var jump_force: float = 400
@export var min_distance: float = 100
@export var gravity: float = 800
@export var damage = 20.0

# Reference to the player
var player: Node2D

func _ready():
	player =  get_tree().get_nodes_in_group("player")[0]
	# Find the first player in the "player" group
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]
	else:
		push_warning("No player found in group 'player'!")

func _physics_process(delta):
	if not player:
		return

	# Calculate direction to player
	var direction = player.global_position - global_position
	var distance = direction.length()

	# Only move if farther than min_distance
	var move_vector = Vector2.ZERO
	
	#if distance > min_distance:
	direction = direction.normalized()
	move_vector.x = direction.x * speed

	# Apply gravity
	velocity.y += gravity * delta

	# Jump if colliding with floor (tilemap)
	if is_on_floor():
		if distance > min_distance and direction.y < -10:  # player is higher
			velocity.y = -jump_force

	if direction.x < 0 and !animated_sprite_2d.flip_h:
		animated_sprite_2d.flip_h = true
	elif direction.x > 0 and animated_sprite_2d.flip_h:
		animated_sprite_2d.flip_h = false
	# Move the enemy
	velocity.x = move_vector.x
	move_and_slide()
	



func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("projectile") and area.get_parent().is_player_projectile:
		
		take_damage(area.get_parent().bullet_collision_info())

		
const ZOMBIE_LEGS = preload("res://Enemies/Zombie/zombie_legs.tres")
const ZOMBIE_TORSO = preload("res://Enemies/Zombie/zombie_torso.tres")
const ZOMBIE_WEAPON = preload("res://Enemies/Zombie/zombie_weapon.tres")

func drop_equipable():
	randomize()
	var drop_percent = randf()
	
	
	
	print("drop percent: " + str(drop_percent))
	if drop_percent < .33:
		var enemy_drop = ENEMY_DROP.instantiate()
		

		get_tree().current_scene.add_child(enemy_drop)
		enemy_drop.initialize(ZOMBIE_WEAPON)
		enemy_drop.global_position = global_position
