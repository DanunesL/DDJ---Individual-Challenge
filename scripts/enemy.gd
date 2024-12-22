extends CharacterBody2D

@export_range(1,100) var mov_speed = 40

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var sprite = $Sprite2D  

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * mov_speed
	move_and_slide()
	
	if Global.weather == "fog":
		set_opacity(0.3)
	else:
		set_opacity(1.0)

func _on_health_died() -> void:
	queue_free()

func set_opacity(alpha: float) -> void:
	if sprite:
		sprite.modulate = Color(1, 1, 1, alpha)
