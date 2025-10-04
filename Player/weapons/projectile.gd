extends Node2D
class_name Projectile

@onready var despawn_timer: Timer = $despawnTimer


var speed: float = 500.0
var direction: Vector2

func set_weapon_data(direction: Vector2, despawn_time: float = 1.0, bullet_speed: float = 500.0):
	despawn_timer.wait_time = despawn_time
	despawn_timer.start()
	
	speed = bullet_speed
	self.direction = direction
		
func _process(delta: float) -> void:
	print("is alive")
	global_position += direction*delta*speed
	print(global_position)

func _on_despawn_timer_timeout() -> void:
	queue_free()
	
