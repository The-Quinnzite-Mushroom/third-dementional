extends bulletSpawner

var spawning_blood: bool = false
@onready var blood_gun: Node2D = $".."

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		shoot()
		spawning_blood = true
		#current_weapon_index = (current_weapon_index + 1) % weapons_data.weapons.size()
		#swap_weapon()
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
		spawning_blood = false
		
func _process(delta: float) -> void:
	if spawning_blood:
		shoot()
		
func spawn_projectile(direction: Vector2):
	print("should spawn shotgun bullets")	
	
	for i in range(-2, 2):
		var shotgun_projectile_direction = direction.rotated(deg_to_rad(float(i)*20.0))
		var new_bullet: Projectile = PROJECTILE.instantiate()
		get_tree().current_scene.add_child(new_bullet)
		new_bullet.global_position = global_position
		new_bullet.set_weapon_data(shotgun_projectile_direction, blood_gun.weapon_projectile)
