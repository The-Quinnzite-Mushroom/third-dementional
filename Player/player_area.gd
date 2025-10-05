extends Area2D
@onready var player: CharacterBody2D = $".."


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
