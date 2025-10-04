extends Node2D

const weapons_data = preload("res://Player/weapons/weapons_data.tres")


var current_weapon = null
var current_weapon_index = 0

func _ready() -> void:
	swap_weapon()

func _input(event):
	if event.is_action_pressed("interact"):
		current_weapon_index = (current_weapon_index + 1) % weapons_data.weapons.size()
		swap_weapon()
		
		
func swap_weapon():
	if current_weapon:
		current_weapon.queue_free()
	
	current_weapon = weapons_data.weapons[current_weapon_index].instantiate()
	print("swapped to: " + current_weapon.name)
	add_child(current_weapon)
	
func _process(delta):
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
	rotation = direction.angle()
