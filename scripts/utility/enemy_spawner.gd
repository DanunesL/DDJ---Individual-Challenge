extends Marker2D
class_name EnemySpawner

@export var enemy_scene : PackedScene
@export var spawn_time = 2

func _ready():
	var timer = Timer.new()
	add_child(timer)
	
	timer.wait_time = spawn_time
	timer.start()
	
	timer.timeout.connect(spawn_enemy)
	
func spawn_enemy():
	var new_enemy = enemy_scene.instantiate()
	owner.add_child(new_enemy)
	
	new_enemy.global_position = global_position
