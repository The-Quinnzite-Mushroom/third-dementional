extends CharacterBody2D
class_name Enemy

var health = 40.0
const ENEMY_DROP = preload("res://Enemies/enemy_drop.tscn")
var is_dying = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("projectile") and area.get_parent().is_player_projectile:
		print("player projectile hit enemy")
		take_damage(area.get_parent().bullet_collision_info())

func take_damage(damage: float):
	health -= damage
	if health <= 0 and !is_dying:
		is_dying = true
		kill_enemy()
		
		
func kill_enemy():
	drop_equipable()
	
	queue_free()
	
func drop_equipable():
	pass
