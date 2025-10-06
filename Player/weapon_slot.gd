extends Node2D
class_name WeaponContainer

const weapons_data = preload("res://Player/weapons/weapons_data.tres")


var current_weapon = null
var current_weapon_index = 0
var drop_data

func _ready() -> void:
	swap_weapon()

func switch_index(index, drop = null):
	current_weapon_index = index
	drop_data = drop
		
func swap_weapon(index: int = -1):
	if current_weapon:
		current_weapon.queue_free()
		
	current_weapon = weapons_data.weapons[current_weapon_index].instantiate()
	
	
	if drop_data:
		drop_data.queue_free()
		drop_data = null
	
	print("swapped to: " + current_weapon.name)
	add_child(current_weapon)
	
	
func _process(delta):
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
	rotation = direction.angle()
