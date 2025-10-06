extends bulletSpawner

@onready var shot_gun: Node2D = $".."



func spawn_projectile(direction: Vector2):
	print("should spawn shotgun bullets")	

	for i in range(-2, 2):
		var shotgun_projectile_direction = direction.rotated(deg_to_rad(float(i)*20.0))
		var new_bullet: Projectile = PROJECTILE.instantiate()
		get_tree().current_scene.add_child(new_bullet)
		new_bullet.global_position = global_position
		new_bullet.set_weapon_data(shotgun_projectile_direction, shot_gun.weapon_projectile)
		
		
	
