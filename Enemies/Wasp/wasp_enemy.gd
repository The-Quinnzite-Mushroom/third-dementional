extends Enemy

const BASE_PROJECTILE = preload("res://Player/weapons/weaponTypes/BaseWeapon/base_projectile.tres")
const PROJECTILE = preload("res://Player/weapons/projectile.tscn")
var hover_height = 5.0

func _ready() -> void:
	pass
	

@export var hover_radius: float = 150.0
@export var speed: float = 150.0
@export var orbit_speed: float = 2.0  # radians per second
@export var jitter_magnitude: float = 30.0  # max random offset
@export var min_height: float = -100.0
@export var shoot_interval: float = 2.0  # seconds between shots

var tracking_distance = 100.0
var player_position: Vector2 = Vector2.ZERO
var angle: float = 0.0  # for circular motion
var offset: Vector2 = Vector2.ZERO  # random jitter

var shoot_timer: float = 0.0

'''
func _ready():
	# Find player dynamically (or assign in editor)
	player = get_tree().get_root().get_node("Main/Player")  # adjust path
	offset = Vector2(randf_range(-jitter_magnitude, jitter_magnitude),
					 randf_range(-jitter_magnitude, jitter_magnitude))
'''


func _process(delta):
	#if player_position.distance_to(global_position) > tracking_distance:
		#return

	# Update angle for orbiting
	angle += orbit_speed * delta

	# Desired position around player
	var target_pos = player_position + Vector2(hover_radius, 0).rotated(angle) + offset
	target_pos.y = min(target_pos.y, min_height)
	# Move towards target smoothly
	var dir = (target_pos - global_position).normalized()
	global_position += dir * speed * delta

	# Optional: occasionally change jitter to avoid perfect orbit
	if randi() % 60 == 0:  # roughly every second
		offset = Vector2(randf_range(-jitter_magnitude, jitter_magnitude),
			randf_range(-jitter_magnitude, jitter_magnitude))
						

	shoot_timer -= delta
	if shoot_timer <= 0.0:
		shoot(Vector2(1, 0))
		shoot_timer = shoot_interval  # reset timer
		
func shoot(direction):
	print("should shoot")
	var new_bullet: Projectile = PROJECTILE.instantiate()
	get_tree().current_scene.add_child(new_bullet)
	new_bullet.global_position = global_position
	new_bullet.set_weapon_data(direction, BASE_PROJECTILE)
	#print(base_weapon.weapon_projectile)
