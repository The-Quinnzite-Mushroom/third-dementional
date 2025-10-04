extends CharacterBody2D


const speed = 200.0
const jump_velocity = -300.0
const GRAVITY = 400

var health = 100
func _ready() -> void:
	update_health()

func _physics_process(delta: float) -> void:
	# Add the gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	#else:
		#velocity.y = 0

	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	

func take_damage(dmg):
	health -= dmg
	update_health()
	if health <= 0:
		get_tree().change_scene_to_file("res://scenes/menus/death_menu.tscn")
		
func update_health():
	$HealthBar.value = health

func _on_area_2d_area_entered(area: Area2D) -> void:
	print("Player area entered by: ",area)
