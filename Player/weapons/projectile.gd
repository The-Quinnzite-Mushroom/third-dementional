extends Node2D
class_name Projectile

@onready var despawn_timer: Timer = $despawnTimer

@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

var projectile_data: ProjectileData 
var direction: Vector2

func set_weapon_data(bullet_direction: Vector2, projectile_data: ProjectileData):
	self.projectile_data = projectile_data
	despawn_timer.wait_time = projectile_data.despawn_time
	despawn_timer.start()
	collision_shape_2d.shape.radius = projectile_data.size
	
	self.direction = bullet_direction

		
func _process(delta: float) -> void:
	global_position += direction*delta*projectile_data.speed

func _on_despawn_timer_timeout() -> void:
	queue_free()
	
