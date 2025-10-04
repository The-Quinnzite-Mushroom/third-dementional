extends Node2D

const PROJECTILE = preload("res://Player/weapons/projectile.tscn")

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		shoot()
		#current_weapon_index = (current_weapon_index + 1) % weapons_data.weapons.size()
		#swap_weapon()

func shoot():

	var mouse_pos = get_global_mouse_position()
	var weapon_direction = (mouse_pos - global_position).normalized()
	spawn_projectile(weapon_direction)
	
func spawn_projectile(direction):
	print("should shoot")
	var new_bullet: Projectile = PROJECTILE.instantiate()
	get_tree().current_scene.add_child(new_bullet)
	new_bullet.global_position = global_position
	new_bullet.set_weapon_data(direction, 10.0)
