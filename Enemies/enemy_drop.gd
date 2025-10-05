extends Node2D

@onready var area_2d: Area2D = $Area2D
@onready var rigid_body_2d: RigidBody2D = $RigidBody2D

var equable_data: EquipableData

func initialize(enemy_drop: EquipableData):
	equable_data = enemy_drop
	
func get_equipable_data():
	return equable_data

func _process(delta: float) -> void:
	area_2d.global_position = rigid_body_2d.global_position

func _on_area_2d_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
