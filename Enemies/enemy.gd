extends Node2D
class_name Enemy

var health = 40.0


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("projectile") and area.get_parent().is_player_projectile:
		print("player projectile hit enemy")
		take_damage(area.get_parent().bullet_collision_info())

func take_damage(damage: float):
	health -= damage
	if health <= 0:
		print("death")
		kill_enemy()
		
		
func kill_enemy():
	queue_free()
