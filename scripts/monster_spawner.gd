extends Node


@export var zombie_enemy: PackedScene
@export var wasp_enemy: PackedScene
@export var grasshoper_enemy: PackedScene
@export var player: Node2D

var spawners;


func _ready():
	spawners = [{"scene":zombie_enemy,"pos":Vector2(655,192),"range":200},
	{"scene":wasp_enemy,"pos":Vector2(1211,530),"range":300},{"scene":wasp_enemy,"pos":Vector2(1271,1650),"range":300},{"scene":wasp_enemy,"pos":Vector2(2242,1488),"range":300},
	{"scene":grasshoper_enemy,"pos":Vector2(4883,33),"range":300},{"scene":grasshoper_enemy,"pos":Vector2(5577,-15),"range":300}

]

	
func attempt_spawn():
	for spawner in spawners:
		if (spawner["pos"].distance_to(player.global_position)< spawner["range"]):
			spawn_enemy(spawner)



func spawn_enemy(spawner):
	print("spawner: ",spawner["scene"])
	var temp = spawner["scene"].instantiate()
	get_parent().add_child(temp)
	temp.position = spawner["pos"]
	

func _on_timer_timeout() -> void:
	attempt_spawn()
	$Timer.start()
