extends Area2D
@onready var player: CharacterBody2D = $".."
@onready var weapon_container: Node2D = $"../weaponContainer"


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("projectile") and !area.get_parent().is_player_projectile:
		print("player projectile hit enemy")
		player.take_damage(area.get_parent().bullet_collision_info())
	if area.is_in_group("zombie_hit_box"):
		print("player projectile hit zombie")
		player.take_damage(area.get_parent().damage)
	if area.is_in_group("grasshopper_hit_box"):
		print("player hit by grasshopper")
		player.take_damage(area.get_parent().damage)
	if area.is_in_group("equipable"):
		
		print(area.get_parent().get_equipable_data().type)
		if area.get_parent().get_equipable_data().type == "weapon":
			
			player.switch_weapon_index(area.get_parent().get_equipable_data().index,  area.get_parent())
		elif area.get_parent().get_equipable_data().type == "legs":
			player.change_legs_index(area.get_parent().get_equipable_data().index, area.get_parent())
		elif area.get_parent().get_equipable_data().type == "torso":
			player.change_torso_index(area.get_parent().get_equipable_data().index, area.get_parent())
			
		#print("hovering over equipable")


func _on_area_exited(area: Area2D) -> void:
	
	if area.is_in_group("equipable"):
		if area.get_parent().get_equipable_data().type == "weapon":
			if area.get_parent().get_equipable_data().index == weapon_container.current_weapon_index:
				player.switch_weapon_index(-1)
			elif area.get_parent().get_equipable_data().type == "legs":
				player.change_legs_index(-1)
			elif area.get_parent().get_equipable_data().type == "torso":
				player.change_torso_index(-1)
			
