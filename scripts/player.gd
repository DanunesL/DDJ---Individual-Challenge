extends CharacterBody2D

@export var mov_speed = 60

@export var bullet_scene : PackedScene
@export var bullet_speed = 100

func movement():
	var mov = Input.get_vector("left", "right", "up", "down")
	velocity = mov * mov_speed
	move_and_slide()
	
func _physics_process(delta):
	movement()
	
func shoot():
	var new_bullet : RigidBody2D = bullet_scene.instantiate()
	owner.add_child(new_bullet)
	new_bullet.global_position = global_position
	
	var mouse_pos = get_global_mouse_position()
	
	var direction = new_bullet.global_position.direction_to(mouse_pos)
	
	if Global.weather == "fog":
		direction += Vector2(randf_range(-1, 1), randf_range(-1, 1))
	
	new_bullet.apply_central_impulse(direction * bullet_speed)

func _input(event):
	if event.is_action_pressed("shoot"):
		shoot()
	
func _on_hurtbox_hurt(damage):
	print(name + " lost " + str(damage) + " HP.")

func _on_health_died() -> void:
	SceneHandler.go_to_menu() 
